class BookingsController < ApplicationController
  def create
    if params[:booking][:name].blank?
      return redirect_to new_event_ticket_path, flash: {error: "Enter your name please!"}
    elsif params[:booking][:email].blank?
      return redirect_to new_event_ticket_path, flash: {error: "Enter your email please!"}
    end

    @booking = Booking.new(booking_params)
    total = 0
    total_quantity = 0

    params[:booking][:tickets].each do |ticket|
      quantity = ticket[:quantity].to_i
      ticket_type = TicketType.find(ticket[:ticket_type_id])
      ticket_type.max_quantity -= quantity
      total += quantity * ticket_type.price
      total_quantity += quantity

      ticket_type.save!

      @booking.tickets << Ticket.new(ticket_type: ticket_type, quantity: quantity)
    end

    return redirect_to new_event_ticket_path, flash: {error: "Choose the quantity please!"} if total_quantity <= 0

    @booking.total = total

    if @booking.save
      redirect_to @booking, flash: {success: "Booking successful!"}
    else
      redirect_to new_event_ticket_path, flash: {error: "Oops! Cannot booking. Please try again!"}
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
