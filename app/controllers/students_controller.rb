class StudentsController < ApplicationController
  before_action :get_users

  def index
    @page_title = 'Student Profiles'
  end

  private

  def get_users
    # FIXME so I think this is better but I bet there is a much better way. I still have
    # lots of sql queries - the if statement.. this is a HACK... FIXME
    #current_user.cohorts.collect(&:users)
    #
    grouped_students = User.all.select(&:student?)
      .group_by { |student| student.cohorts[0].name }
    @students = grouped_students.select { |key, value| value if current_user.cohorts.map(&:name).include?(key) }

    # FIXME this is stupid. all cohorts & students should belong to admin
    if current_user.admin?
      @students = User.all.select(&:student?)
        .group_by { |student| student.cohorts[0].name }
    end
  end
end
