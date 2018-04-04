class MentorsController < ApplicationController
  def index
    @page_title = 'Mentors'
    @mentors = 15.times.map { |_| mentors_payload }
    # @mentors = nil
  end


  private
  
    def mentors_payload
      {
        "avatar": "/assets/user.jpg",   #will change this once we have the API up... logic will be user avatar or stock avatar
        "name": Faker::Name.name,
        "company": Faker::Company.name,
        "specialty": Faker::Job.field,
        "email": Faker::Internet.email,
        "phone": Faker::PhoneNumber.cell_phone,
        "linkedin": "https://www.linkedin.com/company/the-gray-matter-experience/"
      }.as_json
    end
end
