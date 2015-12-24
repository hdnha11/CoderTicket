class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @search = params[:search]
    draft = params[:draft] || false
    if @search
      @events = Event.search(@search)
    elsif draft
      @events = Event.draft_events
    else
      @events = Event.current_events
    end
  end

  def show
    @event = Event.find(params[:id])
    redirect_to root_path, flash: {error: 'This event is not available at this momment'} if @event.draft && !user_signed_in?
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.draft = true
    @event.venue = Venue.find(params[:event][:venue_id])
    @event.category = Category.find(params[:event][:category_id])

    if @event.save
      redirect_to @event, flash: {success: 'Event created!'}
    else
      redirect_to new_event_path, flash: {error: @event.errors.full_messages.to_sentence}
    end
  end

  def update
    is_publish = params[:publish] || false
    if is_publish
      @event = Event.find(params[:id])
      @event.draft = false
      if @event.save
        redirect_to events_path, flash: {success: 'The event has been published!'}
      else
        redirect_to event_path(@event), flash: {error: 'Oops! Something went wrong when publishing.'}
      end
    else
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :starts_at, :ends_at, :hero_image_url, :extended_html_description)
  end
end
