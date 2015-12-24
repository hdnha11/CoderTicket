class Booking < ActiveRecord::Base
  has_many :tickets

  validates_presence_of :tickets

  def add_tickets(tickets)
    total = 0
    total_quantity = 0

    TicketType.transaction do
      tickets.each do |ticket|
        quantity = ticket[:quantity].to_i
        if quantity > 0
          ticket_type = TicketType.find(ticket[:ticket_type_id])
          ticket_type.max_quantity -= quantity
          total += quantity * ticket_type.price
          total_quantity += quantity

          ticket_type.save!

          self.tickets << Ticket.new(ticket_type: ticket_type, quantity: quantity)
        end
      end
    end

    self.total = total

    total_quantity > 0
  end
end
