class Admin::UsersController < Admin::ApplicationController
  include ApplicationHelper
  before_action :admin_authorize,
                :set_user

  def index
    @page_title = 'Students'
    @students = User.select(&:student?)
  end

  def new
    @page_title = 'Add a Student'
    @student = User.new
  end

  def create
    @student = User.new(user_params)

    if @student.save
      #binding.pry
      @student.cohort_ids = params["user"]["cohort_ids"]
      flash[:success] = "#{@student.name.capitalize} has been added"
      redirect_to admin_users_path
    else

      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def edit
    @page_title = 'Edit a Student'
  end

  def update
    student = User.find_by_id(params[:id])

    #NOTE Currently student can only belong to ONE cohort
    remove_student_from_cohort(student) if params["user"]["cohort_ids"].present?

    if student.update_attributes(user_params)
      flash[:success] = "#{student.name.capitalize} has been updated"
      redirect_to admin_users_path
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :role,
                                 :cohort_ids,
                                 user_information: [
                                   :avatar,
                                   :phone,
                                   :school,
                                   :grade,
                                   social_media: [
                                     :instagram,
                                     :linkedin,
                                     :twitter,
                                     :facebook
                                   ]
                                 ])
  end

  def set_user
    @student = User.find_by_id(params[:id])
  end

  def remove_student_from_cohort(student)
    student_cohort = student.cohorts
    student.cohorts.delete(student_cohort) 
    student.cohort_ids = params["user"]["cohort_ids"]
  end
end
