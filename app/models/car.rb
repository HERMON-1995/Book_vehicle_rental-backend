class Car < ApplicationRecord
  belongs_to :user

  has_many :reservations, dependent: :destroy
  # has_many :user, through: :reservations 

  validates :name, presence: true
  validates :model, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :photo, presence: true
end
