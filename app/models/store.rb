class Store < ApplicationRecord
  has_many :staffs

  validates :name, presence: true
  validates :location, presence: true
  validates :hours, presence: true
  validates :description, presence: true
end
