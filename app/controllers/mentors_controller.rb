class MentorsController < ApplicationController
  def index
    @page_title = 'Mentors'
    @mentors = User.all.select(&:mentor?)
  end
end
