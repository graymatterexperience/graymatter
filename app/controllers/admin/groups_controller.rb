class Admin::GroupsController < Admin::ApplicationController
  def index
    @page_title = 'Cohort Groups'
  end

  def create
    req = JSON.parse(request.body.read)
    params.merge!(req)

    cohort = Cohort.find_by_name(req["group"]["cohort"])

    params["group"]["cohort_id"] = cohort.id

    group = Group.new(group_params)

    if group.save
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

  def edit; end

  private

  def group_params
    params.require(:group).permit(:name, :cohort_id, :user_id)
  end
end
