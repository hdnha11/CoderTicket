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
    redirect_to root_path, flash: {error: 'This event is not available at this momment'} if @event.draft
  end
end
