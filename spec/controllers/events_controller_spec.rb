require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads current events into @events" do
      event1 = Event.create!(
        name: 'Event1',
        venue: Venue.new,
        starts_at: DateTime.current,
        ends_at: DateTime.current + 10,
        extended_html_description: 'content',
        category: Category.new,
        draft: false
      )

      event2 = Event.create!(
        name: 'Event2',
        venue: Venue.new,
        starts_at: DateTime.current,
        ends_at: DateTime.current + 11,
        extended_html_description: 'content',
        category: Category.new,
        draft: false
      )

      event3 = Event.create!(
        name: 'Event3',
        venue: Venue.new,
        starts_at: DateTime.current,
        ends_at: DateTime.current + 11,
        extended_html_description: 'content',
        category: Category.new,
        draft: true
      )

      event4 = Event.create!(
        name: 'Event4',
        venue: Venue.new,
        starts_at: DateTime.current,
        ends_at: DateTime.current - 1,
        extended_html_description: 'content',
        category: Category.new,
        draft: true
      )

      get :index

      expect(assigns(:events)).to match_array([event1, event2])
    end
  end
end
