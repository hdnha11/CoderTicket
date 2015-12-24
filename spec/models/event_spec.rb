require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validation' do
    before do
      @event = Event.new(name: 'Event')
    end

    it 'should have extended_html_description' do
      @event.venue = Venue.new
      @event.category = Category.new
      @event.starts_at = DateTime.current
      @event.save
      expect(@event.errors.full_messages).to include("Extended html description can't be blank")
    end

    it 'should have venue' do
      @event.extended_html_description = 'html content'
      @event.category = Category.new
      @event.starts_at = DateTime.current
      @event.save
      expect(@event.errors.full_messages).to include("Venue can't be blank")
    end

    it 'should have category' do
      @event.venue = Venue.new
      @event.extended_html_description = 'html content'
      @event.starts_at = DateTime.current
      @event.save
      expect(@event.errors.full_messages).to include("Category can't be blank")
    end

    it 'should have starts_at' do
      @event.venue = Venue.new
      @event.extended_html_description = 'html content'
      @event.category = Category.new
      @event.save
      expect(@event.errors.full_messages).to include("Starts at can't be blank")
    end

    it 'should not have the same name and venue and start time' do
      venue = Venue.new
      start_time = DateTime.current

      @event.venue = venue
      @event.starts_at = start_time
      @event.extended_html_description = 'html content'
      @event.category = Category.new

      @event.save
      expect(Event.count).to eq(1)

      @event2 = Event.new(name: 'Event', venue: venue, starts_at: start_time, extended_html_description: 'content', category: Category.new)
      @event2.save
      expect(@event2.errors.full_messages).to include('Name has already been taken')
    end
  end

  describe 'class method' do
    before do
      @user = User.create
      @event1 = Event.create(
        name: 'Event',
        venue: Venue.new,
        starts_at: DateTime.current,
        ends_at: DateTime.current + 1,
        extended_html_description: 'content',
        category: Category.new,
        draft: false,
        user: @user
      )
      @event2 = Event.create(
        name: 'Event 2',
        venue: Venue.new,
        starts_at: DateTime.current,
        ends_at: DateTime.current + 10,
        extended_html_description: 'content',
        category: Category.new,
        draft: true,
        user: @user
      )
    end

    describe '#current_events' do
      it 'should return a list of current events' do
        expect(Event.current_events.count).to eq(1)
        expect(Event.current_events).to include(@event1)
      end
    end

    describe '#user_draft_events' do
      it 'should return a list of draft events' do
        expect(Event.user_draft_events(@user)).to include(@event2)
      end
    end

    describe '#user_events' do
      it 'should return a list of events which were created by user' do
        expect(Event.user_events(@user)).to match_array([@event1, @event2])
      end
    end

    describe '#search' do
      it 'should return a list of matched events' do
        expect(Event.search('event')).to match_array([@event1])
      end
    end
  end
end
