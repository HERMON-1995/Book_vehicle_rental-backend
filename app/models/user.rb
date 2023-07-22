class User < ApplicationRecord
  has_many :cars, dependent: :destroy

  has_many :reservation
  has_many :cars, through: :reservation
  
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }
end
