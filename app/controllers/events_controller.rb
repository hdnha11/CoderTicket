class EventsController < ApplicationController
  def index
    @search = params[:search]
    if @search
      @events = Event.search(@search)
    else
      @events = Event.current_events
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
