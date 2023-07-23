# spec/factories/cars.rb
FactoryBot.define do
    factory :car do
      name { 'Sample Car' }
      description { 'Car Description' }
      price { 10000 }
      model { 'Car Model' }
      photo { 'car.jpg' }
      association :user, factory: :user
    end
  end
  