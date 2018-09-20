class EventsController < ApplicationController

  def index
    @events = Event.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @events }
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
