class PagesController < ApplicationController
  def index
    @user = current_user
    @page_title = 'Home'
  end
end
