class Admin::GroupsController < Admin::ApplicationController
  def index
    @page_title = 'Cohort Group'
  end

  def create
    group = Group.new(group_params)
  end

  def new
    binding.pry
    @page_title = 'New Group'
    @group = Group.new
    redirect_to admin_users_path
  end

  def edit; end

  private

  def group_params
    params.require(:group).permit(:name, :cohort_id, :user_id)
  end
end
