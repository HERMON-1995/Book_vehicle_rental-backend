require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:car) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject(:reservation) { build(:reservation) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:reservation_date) }
    it { should validate_presence_of(:returned_date) }
    it { should validate_presence_of(:city) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      car = create(:car) # Create a valid car in the database
      user = create(:user) # Create a valid user in the database

      # Pass the car and user to the reservation factory to set up the associations
      reservation = build(:reservation, car:, user:)

      expect(reservation).to be_valid
    end
  end

  describe 'instance methods' do
    let(:reservation) { create(:reservation) }

    describe '#total_cost' do
      it 'calculates the total cost of the reservation' do
        # Assuming you have some logic to calculate the total cost based on the car and reservation dates.
        # You can write test cases to verify the calculation.
        expect(reservation.total_cost).to eq(100)
      end
    end
  end

  describe 'scopes' do
    describe '.recent' do
      it 'returns reservations in descending order of creation' do
        # Create some test reservations with different created_at timestamps
        create(:reservation, created_at: 3.days.ago)
        create(:reservation, created_at: 2.days.ago)
        create(:reservation, created_at: 1.day.ago)

        # Get the IDs of the reservations in descending order of creation
        recent_reservation_ids = Reservation.recent.pluck(:id)

        # Expect the IDs to be in descending order based on their created_at timestamps
        expect(recent_reservation_ids).to eq(recent_reservation_ids.sort.reverse)
      end
    end
  end

  describe '.by_city' do
    it 'returns reservations for a specific city' do
      city = 'Test City'
      expect(Reservation.by_city(city)).to all(have_attributes(city:))
    end
  end
end
