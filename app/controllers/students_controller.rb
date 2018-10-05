class StudentsController < ApplicationController

  def index
    @page_title = 'Student Profiles for Group One'
    #@students = 8.times.map { |student| student_payload }
    # FIXME so I think this is better but I bet there is a much better way. I still have
    # lots of sql queries - the if statement.. this is a HACK... FIXME
    all_students = User.all.select(&:student?)
    @students = all_students.group_by { |student| student.cohorts[0].name }
    if current_user.student?
      @students = @students.select { |k, _| k == current_user.cohorts[0].name }
    end
  end

end
