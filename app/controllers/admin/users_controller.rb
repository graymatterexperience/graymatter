class Admin::UsersController < Admin::ApplicationController
  include ApplicationHelper
  before_action :admin_authorize,
                :set_user

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
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

    @page_title = 'Students'
    # FIXME this is SO ugly.. wow...
    @cohorts_groups = Cohort.all

    # FIXME This need to pluck only the users that are not archived
    @cohorts = Cohort.all.collect(&:users)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cohorts }
    end
  end

  def new
    @page_title = 'Add a Student'
    @student = User.new
  end

  def create
    @student = User.new(user_params)

    if @student.save
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
    #NOTE Currently student can only belong to ONE cohort
    remove_student_from_cohort(@student) if params["user"]["cohort_ids"].present?

    if @student.update_attributes(user_params)
      flash[:success] = "#{@student.name.capitalize} has been updated"
      redirect_to admin_users_path
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy; end

  def archive_student
    @student.archive = true
    if @student.save
      flash[:success] = "#{@student.name.capitalize} has been Archived"
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
