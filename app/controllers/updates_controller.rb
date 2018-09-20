class UpdatesController < ApplicationController
  def index
    @page_title = 'Updates'
    @upcoming_events = Event.all.select { |x| x.event_this_month? }
      .sort_by(&:start)
  end
end

#@upcoming_events = Event.all.select { |x| x.event_this_month? }
#.sort_by(&:start)
