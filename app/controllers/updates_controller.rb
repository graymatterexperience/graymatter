class UpdatesController < ApplicationController
  def index
    @page_title = 'Updates'
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
