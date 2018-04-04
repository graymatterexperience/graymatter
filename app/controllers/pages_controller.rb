class PagesController < ApplicationController
  def index
    #TODO we want to move this to a before action
    if logged_in?
      @page_title = 'Home'
      @page_title = 'Home'
      @pages_payload = pages_payload
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
end
