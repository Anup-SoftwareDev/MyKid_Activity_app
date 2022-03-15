class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_activity, only: [:show, :edit, :update, :destroy ]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index
    @activities= Activity.all
   #@categories = Category.all
  end

  def show

    @registrations = Registration.all
    
  end

  def new
    @activity = Activity.new
    #@categories = Category.all
  end

  def create
    @activity = current_user.activities.new(activity_params)
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
    if @activity.save 
      redirect_to @activity, notice: "Activity successfully updated"
    else
      
      set_form_vars
      render "edit", notice: "Something went wrong"
    end 

  end
  
  def destroy

    @activity.destroy
    redirect_to activities_path, notice: "Successfully deleted"

  end

  def myactivity
    @activities = Activity.all
    #Activity.new = @activities
    
end

def booking

  @registration = Registration.new
  @activities = Activity.all
  
end

def book
  
  @registration = Registration.new(registration_params)

  @registration.save
  redirect_to book_path, notice: "Child Successfully Registered"

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

    @activity = Activity.find(params[:id])

  end

  def set_form_vars
    @categories = Category.all
   
  end 


end
