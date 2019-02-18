class Admin::GroupsController < Admin::ApplicationController
  def index
    @page_title = 'Cohort Groups'
    @groups = Group.all
    params['group_id'] && group = Group.find_by_id(params['group_id'])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: group.users }
    end
  end

  def create
    req = JSON.parse(request.body.read)
    params.merge!(req)
    cohort = Cohort.find_by_name(req["group"]["cohort"])
    params["group"]["cohort_id"] = cohort.id
    group = Group.new(group_params)

    if group.save
      User.where(id: params["group"]["students"])
          .each do |student|
            student.group_id = group.id
            student.save!
          end
      flash[:success] = 'Group has been created'
      respond_to do |format|
        msg = { :status => "ok", :message => "Success!" }
        format.json { render :json => msg } # don't do msg.to_jsonVd
      end
    else
      flash[:error] = 'invalid submission'
      respond_to do |format|
        msg = { :status => 400, :message => "Error" }
        format.json { render :json => msg } # don't do msg.to_jsonVd
      end
    end
  end

  def new
    @page_title = 'New Group'
    @group = Group.new
    @cohorts = Cohort.all
  end

  def edit
    @page_title = 'Edit Group'
    @group = Group.find_by_id(params[:id])
    @cohort_group = {
      group: @group,
      cohort: @group.cohort,
      selected_students: @group.users
    }
  end

  def update
    req = JSON.parse(request.body.read)
    @group = Group.find_by_id(params[:id])
    params["group"] = req

    @group.users.each do |student|
      student = student 
      student.group_id = nil
      student.save!
    end
    # @group.users { |student| student.remove_from_group && student.save! }
    
    if @group.update_attributes(group_params)
      User.where(id: params["group"]["students"])
          .each do |student|
            puts 'created a new user babay'
            student.group_id = @group.id
            student.save!
          end

      flash[:success] = "#{@group.name.capitalize} has been updated"
      respond_to do |format|
        msg = { :status => "ok", :message => "Success!" }
        format.json { render :json => msg } # don't do msg.to_jsonVd
      end
      # redirect_to admin_users_path(group: @group)
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    group = Group.find_by_id(params[:id])
    group.destroy
    flash[:success] = 'Group removed'
    redirect_to admin_groups_path
  end

  def students_by_group
    students = Group.find_by_id(params[:id]).users

    respond_to do |format|
      msg = { status: 'ok', message: 'Success!', data: students }
      format.json { render json: msg }
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :cohort_id, :user_id)
  end

  def add_student_to_group(student)
  end
end
