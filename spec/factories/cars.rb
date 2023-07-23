# spec/factories/cars.rb
FactoryBot.define do
  factory :car do
    name { "Car Name" }
    description { "Car Description" }
    photo { "car.jpg" }
    price { 10000 }
    model { "Car Model" }
    user_id { create(:user).id }
  end
end
