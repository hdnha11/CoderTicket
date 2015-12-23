class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    total = 0

    params[:booking][:tickets].each do |ticket|
      quantity = ticket[:quantity].to_i
      ticket_type = TicketType.find(ticket[:ticket_type_id])
      ticket_type.max_quantity -= quantity
      total += quantity * ticket_type.price

      ticket_type.save!

      @booking.tickets << Ticket.new(ticket_type: ticket_type, quantity: quantity)
    end

    @booking.total = total

    if @booking.save
      redirect_to @booking
    else
      redirect_to new_event_booking_path
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:name, :email, :address)
  end
end
