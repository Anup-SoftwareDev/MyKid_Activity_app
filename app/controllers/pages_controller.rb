class PagesController < ApplicationController
before_action :authenticate_user!, only: [:restricted]
    def home

    end
    def restricted

    end

    def myactivity
        @activities= Activity.all
        #@activity = Activity.find(params[:id])
    end

end
