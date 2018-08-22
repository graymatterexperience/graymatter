class UpdatesController < ApplicationController
  def index
    @page_title = 'Updates'
    @events = Event.all
    @events_by_date = @events.group_by(&:the_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
