# spec/factories/reservation.rb
FactoryBot.define do
  factory :reservation do
    city { 'MyString' }
    reservation_date { '2023-07-20' }
    returned_date { '2023-07-21' }
    association :car # Ensure valid association with Car
    association :user # Ensure valid association with User
  end
end
