class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :booking]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index
    @activities= Activity.all.includes(:category)     #egerloading introduced to speed queries up with category given priority
                                                      #Index page requires all the activities to be listed and hence
                                                      #it is necessary to load Everything from the Activity database.
  end

  def show

    @registrations = Registration.all.includes(:user)  #eager loading - an instance variable @registration created
    session = Stripe::Checkout::Session.create(         #all registrations are loaded into the variable
      payment_method_types: ['card'],
      customer_email:current_user && current_user.email,    #Stripe method used for payments
      line_items: [
        {
          name: @activity.title,
          description: @activity.description,
          amount: @activity.price, 
          currency: 'aud',
          quantity: 1
        }
      ],
      payment_intent_data: {
        metadata: {
          user_id: current_user && current_user.id, 
          listing_id: @activity.id
        }
      },
      success_url: "#{root_url}bookings/#{@activity.id}", 
      cancel_url: root_url
    )

    @session_id = session.id
      
  end

  def new
    @activity = Activity.new          #new instance variable created to be write a new Activity into the database.
    
  end

  def create
    @activity = current_user.activities.new(activity_params)           #New activity is wrtten to the database
    if @activity.save 
      redirect_to @activity, notice: "Activity successfully created"
    else
      set_form_vars
      render "new", notice: "Something went wrong"
    end 
  end

  def edit


  end

  def update

    @activity.update(activity_params)
    if @activity.save                                                   #a new activity is updated using the instance variable
      redirect_to @activity, notice: "Activity successfully updated"
    else
      
      set_form_vars
      render "edit", notice: "Something went wrong"
    end 

  end
  
  def destroy

    @activity.destroy                                               #deleting an activity witht he instance variable
    redirect_to activities_path, notice: "Successfully deleted"

  end

  def myactivity
    @activities = Activity.all.includes(:category) # Eager loading
    #Activity.new = @activities
    
end

def mykidactivity

  @activities = Activity.all.includes(:category)   # Eager loading - need to display acivities of the kids
  @registrations = Registration.all.includes(:user)    # Eager loading - also have to display information from registrations

end

def booking

  @registration = Registration.new      #new registration to be created
  @activities = Activity.all            #all activities loaded up to perform booking
  
  
end

def book
  
  @registration = Registration.new(registration_params)      #new registration to be created with instance variable


  if @registration.save 
    redirect_to mykidactivities_path, notice: "Activity successfully updated"
  else
    
    redirect_to bookings_path, notice: "Something went wrong"
    
  end 

end



  private

  def activity_params
    params.require(:activity).permit(:title, :price, :category_id, :description, :picture)
  end

  def registration_params
    params.require(:registration).permit(:user_id, :activity_id, :name, :surname, :contact_no, :age)
  end

  def authorize_user 
    if @activity.user_id != current_user.id
      flash[:alert] = "You don't have permission to do that"
      redirect_to activities_path
    end 
end 

  def set_activity

    @activity = Activity.find(params[:id])          #instance variable saved to show specific activities

  end

  def set_form_vars
    @categories = Category.all                    #all categories are loaded to set up activities
   
  end 


end
