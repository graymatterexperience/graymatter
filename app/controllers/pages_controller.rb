class PagesController < ApplicationController
  def index
    #TODO we want to move this to a before action
    if logged_in?
      @page_title = 'Home'
      @page_title = 'Home'
      @pages_payload = pages_payload
      @tasks = todos.as_json
    else
      redirect_to login_url
    end
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
