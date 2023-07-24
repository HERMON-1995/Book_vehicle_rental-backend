# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :user_id, presence: true
  validates :reservation_date, presence: true
  validates :returned_date, presence: true
  validates :city, presence: true

  # Define the scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_city, -> (city) { where(city: city) }

  def total_cost
    # Calculate the duration of the reservation in days
    duration_in_days = (returned_date - reservation_date).to_i

    # Get the price of the car
    car_price = car.price

    # Calculate the total cost based on the duration and car price
    total_cost = duration_in_days * car_price.to_i

    # Return the total cost as a float with 2 decimal places
    total_cost.to_f / 100
  end
end
