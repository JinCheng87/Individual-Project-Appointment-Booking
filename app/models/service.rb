class Service < ApplicationRecord
  resourcify
  has_and_belongs_to_many :appointments
end
