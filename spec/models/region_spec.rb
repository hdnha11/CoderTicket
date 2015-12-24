require 'rails_helper'

RSpec.describe Region, type: :model do
  describe 'validation' do
    describe 'name' do
      it 'should not add the same region name' do
        @region1 = Region.new(name: 'Ho Chi Minh')
        @region2 = Region.new(name: 'Ho Chi Minh')

        @region1.save
        expect(Region.count).to eq(1)

        @region2.save
        expect(@region2.errors.full_messages).to include 'Name has already been taken'
      end

      it "should be in ['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong']" do
        @region = Region.new(name: 'Can Tho')

        @region.save
        expect(@region.errors.full_messages).to include('Name is not included in the list')
      end
    end
  end
end
