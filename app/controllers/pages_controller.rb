class PagesController < ApplicationController
  def index
    if logged_in?
      @page_title = 'Home'
    else
      redirect_to login_url
    end
  end
end
