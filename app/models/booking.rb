class Booking < ActiveRecord::Base
  has_many :tickets

  validates_presence_of :tickets
end
