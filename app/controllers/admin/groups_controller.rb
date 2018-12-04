class Admin::GroupsController < Admin::ApplicationController
  def index
    @page_title = 'Cohort Groups'
  end

  def create
    group = Group.new(group_params)
    redirect_to home_path
  end

  def new
    # binding.pry
    @page_title = 'New Group'
    @group = Group.new
  end

  def edit; end

  private

  def group_params
    params.require(:group).permit(:name, :cohort_id, :user_id)
  end
end
