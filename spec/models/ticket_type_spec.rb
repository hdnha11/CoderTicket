require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe 'validation' do
    describe 'max_quantity' do
      it 'should throw an error if it is not a number' do
        @ticket_type = TicketType.new(max_quantity: 'text')

        @ticket_type.save
        expect(@ticket_type.errors.full_messages).to include('Max quantity is not a number')
      end

      it 'should be greater than or equal to zero' do
        @ticket_type = TicketType.new(max_quantity: -1)

        @ticket_type.save
        expect(@ticket_type.errors.full_messages).to include('Max quantity must be greater than or equal to 0')
      end

      it 'can be save if valid' do
        @ticket_type = TicketType.new(max_quantity: 1)

        @ticket_type.save
        expect(TicketType.count).to eq(1)
      end
    end
  end
end
