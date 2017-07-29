class Appointment < ApplicationRecord
  resourcify
  belongs_to :staff
  belongs_to :store
  has_and_belongs_to_many :services
end
