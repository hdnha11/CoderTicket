class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new
    redirect_to root_path if @event.ends_at < DateTime.current
  end
end
