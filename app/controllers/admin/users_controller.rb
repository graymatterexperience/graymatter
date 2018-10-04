# NOTES: this controller handles the creation of both sutdent AND metnors

class Admin::UsersController < Admin::ApplicationController
  include ApplicationHelper
  before_action :admin_authorize,
                :set_user

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end

  end

  def index
    # I need to change this table too has_many through. I think that will solve
    # my issues with group_by
    # NOTES can I do all this modifications in serializor
    # t.name.split(' ').join('_').to_sym
    #FIXME OMG I want to puke on the below line of code
    # this is such HACK
    #students = User.all
    #@students = students.select { |student| student.student? &&
                                  #!student.archived? }
    #@cohorts = Cohort.all.map { |x| {x.name => x.users} }.flatten
    #Cohort.all.group_by { |x| x.collect(&:users) }
    #@cohorts = @cohorts_groups.group_by { |k| {k.name => k.users} }
    # I want a key with cohort name with the value being the students that belong
    # to that cohort (should be easy????)

    if params[:user] == 'student'
      @student = true
      @page_title = 'Students'
      @button_title = 'Add Student'
      @form = 'students_index'
      # FIXME this is SO ugly.. wow...
      @cohorts_groups = Cohort.all

      # FIXME This need to pluck only the users that are not archived
      @cohorts = Cohort.all.collect(&:users)
    end

    if params[:user] == 'mentor'
      @mentor = true
      @page_title = 'Mentors'
      @button_title = 'Add Mentor'
      @form = 'mentors_index'
      # FIXME this is SO ugly.. wow...
      @cohorts_groups = Cohort.all

      # FIXME This need to pluck only the users that are not archived
      @mentors = User.all.select(&:mentor?)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cohorts }
    end
  end

  def new
    @user = User.new
    if params[:user] == 'mentor'
      @page_title = 'Add a Mentor'
      @mentor = User.new
      @form = 'mentor_form'
    end

    if params[:user] == 'student'
      @page_title = 'Add a Student'
      @student = User.new
      @form = 'student_form'
    end

    
    # NOTES I think it would be cool if I could figure out how to render from here
    # always get missing template _application
    #if params[:user] == 'mentor'
      ##render :partial => 'mentor_form', :layout => 'application'
    #end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.cohort_ids = params["user"]["cohort_ids"]
      flash[:success] = "#{@user.name.capitalize} has been added"
      redirect_to admin_users_path(user: @user.role)
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def edit
    if @user.mentor?
      @page_title = 'Edit a Mentor'
      @form = 'mentor_form'
    end

    if @user.student?
      @page_title = 'Edit a Student'
      @form = 'student_form'
    end
  end

  def update
    #NOTE Currently student can only belong to ONE cohort
    remove_student_from_cohort(@user) if params["user"]["cohort_ids"].present?

    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name.capitalize} has been updated"
      redirect_to admin_users_path(user: @user.role)
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy; end

  # FIXME this should be archive_user
  def archive_student
    @user.archive = true
    if @user.save
      flash[:success] = "#{@user.name.capitalize} has been Archived"
      redirect_to admin_users_path
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

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
                                   :company,
                                   :specialty,
                                   :compnay_logo,
                                   social_media: [
                                     :instagram,
                                     :linkedin,
                                     :twitter,
                                     :facebook
                                   ]
                                 ])
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def remove_student_from_cohort(student)
    student_cohort = student.cohorts
    student.cohorts.delete(student_cohort) 
    student.cohort_ids = params["user"]["cohort_ids"]
  end
end
