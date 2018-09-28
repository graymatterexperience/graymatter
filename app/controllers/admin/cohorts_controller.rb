class Admin::CohortsController < ApplicationController
  before_action :admin_authorize,
                :set_cohort

  def index
    @page_title = 'Cohorts'
    @cohorts = Cohort.order(created_at: :desc)
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
      redirect_to admin_cohorts_path
    else
      flash[:error] = 'invalid submission'
      render 'new'
    end
  end

  def edit
    @page_title = 'Edit Cohort'
    @cohort
  end

  def update
    #TODO this is so ugly... have to fix this.  Has to be a way to pass the right
    #params structure in rails
    params[:cohort][:settings] = { color: params[:cohort][:color] }

    if @cohort.update_attributes(cohort_params)
      flash[:success] = 'Cohort updated'
      redirect_to admin_cohorts_path
    else
      flash[:error] = 'invalid submission'
      render 'edit'
    end
  end

  def destroy
    cohort = Cohort.find_by_id(params[:id])
    cohort.destroy
    flash[:success] = 'Cohort removed'
    redirect_to admin_cohorts_path
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name,
                                   settings: [
                                     :color
    ])
  end

  def set_cohort
    @cohort = Cohort.find_by_id(params[:id])
  end
end
