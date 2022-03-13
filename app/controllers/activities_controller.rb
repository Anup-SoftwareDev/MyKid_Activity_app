class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index
    @activities= Activity.all
   #@categories = Category.all
  end

  def show
    
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

  end

  private

  def activity_params
    params.require(:activity).permit(:title, :price, :category_id, :description)
  end

  def set_activity

    @activity = Activity.find(params[:id])

  end

  def set_form_vars
    @categories = Category.all
   
  end 


end
