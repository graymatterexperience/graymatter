class UpdatesController < ApplicationController
  def index
    @page_title = 'Updates'
    @upcoming_events = Event.all.sort_by(&:start)
    #@events_by_date = @events.group_by(&:the_date)
    #@date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
