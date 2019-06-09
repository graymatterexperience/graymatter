class GroupsController < ApplicationController
  before_action :set_current_user

  def index
    @page_title = 'Groups'
    cohorts = Cohort.all

    # NOTES: not sure this is the right way about doing this
    # I feel this shoujld be handled in the view with componats
    if current_user.admin?
      @grouped_by_cohort = cohorts.map { |cohort| { cohort.name.to_s => cohort.groups } }
    elsif current_user.student?
      @grouped_by_cohort = [{ current_user.cohorts[0].name => current_user.cohorts[0].groups }]
    end
    @current_user_profile = set_current_user
  end

  def show
    group = Group.find_by_id(params[:id])
    @page_title = group.name
    @group_payload = group.users
    @tasks = todos
  end

  private

  def set_current_user
    {
      "name": current_user.name,
      "role": current_user.role?,
      "group_name": current_user.group_name
    }
  end

  def todos
    [
      {
        task: 'upload pitch deck',
        assigned_to: '@name',
        in_complete: true,
        completed: false,
        in_progress: false
      },
      {
        task: 'contact mentor',
        assigned_to: '@name',
        in_complete: false,
        completed: true,
        in_progress: false
      },
      {
        task: 'research stuff',
        assigned_to: '@name', # this needs to be a student ID I beleive
        in_complete: false,
        completed: true,
        in_progress: false
      },
      {
        task: 'email team',
        assigned_to: '@name', # this needs to be a student ID I beleive
        in_complete: false,
        completed: false,
        in_progress: true
      }
    ]
  end
end
