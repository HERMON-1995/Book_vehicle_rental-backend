class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :cars, through: :reservations

  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }
end
