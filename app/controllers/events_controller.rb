class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @search = params[:search]
    me = params[:me] || false
    draft = params[:draft] || false
    if @search
      @events = Event.search(@search)
    elsif draft
      @events = Event.user_draft_events(current_user)
    elsif me
      @events = Event.user_events(current_user)
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

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.draft = true
    @event.starts_at = DateTime.strptime(params[:event][:starts_at], '%m/%d/%Y')
    @event.ends_at = DateTime.strptime(params[:event][:ends_at], '%m/%d/%Y')
    @event.venue = Venue.find(params[:event][:venue_id])
    @event.category = Category.find(params[:event][:category_id])

    if @event.save
      redirect_to @event, flash: {success: 'Event created!'}
    else
      redirect_to new_event_path, flash: {error: @event.errors.full_messages.to_sentence}
    end
  end

  def update
    @event = Event.find(params[:id])

    return redirect_to events_path(@event), flash: {error: 'You have no permission to update this event.'} if current_user != @event.user

    is_publish = params[:publish] || false
    success_message = ''
    go_where = nil

    if is_publish
      @event.draft = false
      success_message = 'The event has been published!'
      go_where = events_path
    else
      @event.venue = Venue.find(params[:event][:venue_id])
      @event.category = Category.find(params[:event][:category_id])
      @event.name = params[:event][:name]
      @event.starts_at = DateTime.strptime(params[:event][:starts_at], '%m/%d/%Y')
      @event.ends_at = DateTime.strptime(params[:event][:ends_at], '%m/%d/%Y')
      @event.hero_image_url = params[:event][:hero_image_url]
      @event.extended_html_description = params[:event][:extended_html_description]
      success_message = 'The event has been updated!'
      go_where = event_path(@event)
    end

    if @event.save
      redirect_to go_where, flash: {success: success_message}
    else
      redirect_to event_path(@event), flash: {error: 'Oops! Something went wrong when publishing.'}
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :hero_image_url, :extended_html_description)
  end
end
