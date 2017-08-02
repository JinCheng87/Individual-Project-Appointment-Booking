class Service < ApplicationRecord
  resourcify
  has_and_belongs_to_many :appointments
  validates :name, presence: true
  validates :duration, presence: true
  validates :category, presence: true
  validates :price, presence:true
end
