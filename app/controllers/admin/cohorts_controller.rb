class Admin::CohortsController < ApplicationController
  before_action :admin_authorize

  def index
    @show_buttons = false
    @page_title = 'Cohorts'
    @cohorts = Cohort.all
  end

  def new
    @page_title = 'Add Cohort'
    @cohort = Cohort.new
  end

  def create
    # TODO I HATE this below have to figure out how to use a form to get json
    cohort = Cohort.new(cohort_params)
    cohort.settings = { color: params[:cohort][:color] }

    if cohort.save
      flash[:success] = 'Your cohort has been created'
      redirect_to home_path
    else
      flash[:error] = 'invalid submission'
      render 'new'
    end
  end

  def destroy

  end

  private

  def cohort_params
    params.require(:cohort).permit(:name,
                                   settings: [
                                     :color
                                   ])
  end
end
