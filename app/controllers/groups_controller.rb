class GroupsController < ApplicationController
  before_action :set_images

  def index
    @page_title = 'Groups'
    @groups = group_payload
    cohorts = Cohort.all
    @grouped_by_cohort = cohorts.map { |cohort| { cohort.name.to_s => cohort.groups } }
  end

  def show
    # below has to be dynamic
    @page_title = 'Group 1'
    @group_payload = 8.times.map { |_student| student_payload }
    @tasks = todos
  end

  private

  def group_payload
    [
      {
        group_name: 'Group One',
        group_image: 'group.jpg'
      },
      {
        group_name: 'Group Two',
        group_image: 'group-1.png'
      },
      {
        group_name: 'Group Three',
        group_image: 'group-2.png'
      },
      {
        group_name: 'Group Four',
        group_image: 'group-3.jpg'
      },
      {
        group_name: 'Group Five',
        group_image: 'group-4.gif'
      }
    ]
  end

  private

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

  def student_payload
    {
      firstName: Faker::Name.first_name,
      lastName: Faker::Name.last_name,
      fullName: Faker::Name.name,
      group_id: 123_412,
      information: {
        group: 'Cool Group Name',
        school: 'South Highschool',
        grade: '11',
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.cell_phone,
        socialMedia: {
          facebook: 'https://www.facebook.com/graymatterexp',
          twitter: 'https://twitter.com/graymatterexp',
          linkedin: 'https://www.linkedin.com/company/the-gray-matter-experience/',
          instagram: 'https://www.instagram.com/graymatterexp/'
        },
        avatar: get_image
      }
    }.as_json
  end

  def set_images
    # TODO: remove below when data base set
    @@images = %w[man-4 lady-4 man-1 man-2 lady-2 lady-3 man-3 lady-1]
  end

  def get_image
    # TODO: remove below when data base set
    @@images.pop
  end
end
