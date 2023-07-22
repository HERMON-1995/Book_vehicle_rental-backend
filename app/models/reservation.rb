class Reservation < ApplicationRecord
  validates :reservation_date, presence: true 
  validates :returned_date, presence: true 
  validates :car_id, presence: true
  validates :user_id, presence: true
  validates :city, presence: true

  # associations 
  belongs_to :user 
  belongs_to :car
end
class Reservation < ApplicationRecord
    belongs_to :car
    belongs_to :user

    validates :user_id, presence: true
    validates :reservation_date, presence: true
    validates :returned_date, presence: true
    validates :user_id, presence: true
    validates :city, presence: true
end

  