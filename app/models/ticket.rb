class Ticket < ActiveRecord::Base
  belongs_to :booking
  belongs_to :ticket_type
end
