require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before do
    @event = Event.new(
      id: 1,
      name: 'Merry Christmas',
      venue: Venue.new,
      starts_at: DateTime.current,
      ends_at: DateTime.current + 1.day,
      extended_html_description: 'Best friends are to friendship like Christmas is to the other holidays: always on top. Have a merry one.',
      category: Category.new,
      draft: false
    )
  end

  it 'displays the event name' do
    assign(:event, @event)
    render
    expect(rendered).to include('Merry Christmas')
  end

  it 'displays the event description' do
    assign(:event, @event)
    render
    expect(rendered).to include('Have a merry one')
  end
end
