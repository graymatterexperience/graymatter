class PagesController < ApplicationController
  before_action :authorize

  def index
      @show_buttons = true
      @page_title = 'Home'
      @pages_payload = pages_payload
      @tasks = todos.as_json
  end

  private
  def pages_payload
    {
      facebook: "https://www.facebook.com/graymatterexp",
      twitter: "https://twitter.com/graymatterexp",
      linkedin: "https://www.linkedin.com/company/the-gray-matter-experience/",
      instagram: "https://www.instagram.com/graymatterexp/"
    }.as_json
  end

  def todos
    [
      {
        task: "upload pitch deck",
        assigned_to: "@name",
        in_complete: true,
        completed: false,
        in_progress: false
      },
      {
        task: "contact mentor",
        assigned_to: "@name",
        in_complete: false,
        completed: true,
        in_progress: false
      },
      {
        task: "research stuff",
        assigned_to: "@name", # this needs to be a student ID I beleive
        in_complete: false,
        completed: true,
        in_progress: false
      },
      {
        task: "email team",
        assigned_to: "@name", # this needs to be a student ID I beleive
        in_complete: false,
        completed: false,
        in_progress: true
      }
    ]
  end
end
