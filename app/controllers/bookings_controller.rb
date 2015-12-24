class BookingsController < ApplicationController
  def create
    if params[:booking][:name].blank?
      return redirect_to new_event_ticket_path, flash: {error: "Enter your name please!"}
    elsif params[:booking][:email].blank?
      return redirect_to new_event_ticket_path, flash: {error: "Enter your email please!"}
    end

    @booking = Booking.new(booking_params)

    begin
      unless @booking.add_tickets(params[:booking][:tickets])
        return redirect_to new_event_ticket_path, flash: {error: "Choose the quantity please!"}
      end
    rescue => ex
      return redirect_to new_event_ticket_path, flash: {error: "Oops! #{ex}"}
    end

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
