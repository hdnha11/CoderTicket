require 'rails_helper'

RSpec.describe "events/index", type: :view do
  it 'should contain Discover upcoming events' do
    assign(:events, [])
    render
    expect(rendered).to include('Discover upcoming events')
  end

  it 'will render _card partial for each event' do
    category = Category.new
    venue = Venue.new

    event1 = Event.create!(
      name: 'Event 1',
      starts_at: DateTime.current - 1.days,
      ends_at: DateTime.current + 2.day,
      category: category,
      venue: venue,
      draft: false,
      extended_html_description: 'content'
    )
    event2 = Event.create!(
      name: 'Event 2',
      starts_at: DateTime.current - 1.day,
      ends_at: DateTime.current + 1.day,
      category: category,
      venue: venue,
      draft: false,
      extended_html_description: 'content'
    )
    event3 = Event.create!(
      name: 'Event 3',
      starts_at: DateTime.current - 1.days,
      ends_at: DateTime.current + 3.days,
      category: category,
      venue: venue,
      draft: false,
      extended_html_description: 'content'
    )
    event4 = Event.create!(
      name: 'Event 4',
      starts_at: DateTime.current - 2.day,
      ends_at: DateTime.current + 4.day,
      category: category,
      venue: venue,
      draft: false,
      extended_html_description: 'content'
    )

    assign(:events, [event1, event2, event3, event4])

    render
    expect(view).to render_template(:partial => '_card', :count => 4)
  end
end
