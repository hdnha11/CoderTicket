require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe 'validation' do
    describe 'name' do
      it 'should not add the same venue name' do
        @venue1 = Venue.new(name: 'Venue')
        @venue2 = Venue.new(name: 'Venue')

        @venue1.save
        expect(Venue.count).to eq(1)

        @venue2.save
        expect(@venue2.errors.full_messages).to include 'Name has already been taken'
      end
    end
  end
end
