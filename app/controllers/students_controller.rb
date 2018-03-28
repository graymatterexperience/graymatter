class StudentsController < ApplicationController
  # TODO remove below when data base set
  before_action :set_images

  def index
    @page_title = 'Student Profiles'
    @students = 8.times.map { |student| student_payload }
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
  end

  private

  def student_payload
      {
        firstName: Faker::Name.first_name,
        lastName: Faker::Name.last_name,
        fullName: Faker::Name.name,
        group_id: 123412,
        information: {
          group: 'Cool Group Name',
          school: 'South Highschool',
          grade: '11',
          email: Faker::Internet.email,
          phone: Faker::PhoneNumber.cell_phone,
          socialMedia: {
            facebook: "https://www.facebook.com/graymatterexp",
            twitter: "https://twitter.com/graymatterexp",
            linkedin: "https://www.linkedin.com/company/the-gray-matter-experience/",
            instagram: "https://www.instagram.com/graymatterexp/"
          },
          avatar: get_image
        }
      }.as_json
  end

  def set_images
  # TODO remove below when data base set
    @@images = %w[man-4 lady-4 man-1 man-2 lady-2 lady-3  man-3 lady-1 ]
  end

  def get_image
  # TODO remove below when data base set
    @@images.pop
  end
end
