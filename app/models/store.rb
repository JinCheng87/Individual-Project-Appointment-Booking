class Store < ApplicationRecord
  resourcify
  has_many :staffs
  has_many :appointments

  validates :name, presence: true
  validates :location, presence: true
  validates :hours, presence: true
  validates :description, presence: true

  geocoded_by :location
  after_validation :geocode
end
