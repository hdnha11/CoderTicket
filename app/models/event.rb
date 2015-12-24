class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.current_events
    where('draft is not true and ends_at >= ?', DateTime.current)
  end

  def self.search(query)
    where('draft is not true and lower(name) like ?', "%#{query.downcase}%")
  end
end
