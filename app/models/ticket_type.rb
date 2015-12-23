class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :tickets

  validates :max_quantity, :numericality => { :greater_than_or_equal_to => 0 }
end
