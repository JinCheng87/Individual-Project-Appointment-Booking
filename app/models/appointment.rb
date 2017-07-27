class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :staff
  belongs_to :store
end
