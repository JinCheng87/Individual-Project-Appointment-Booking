class Appointment < ApplicationRecord
  resourcify
  belongs_to :staff
  belongs_to :store
  has_and_belongs_to_many :services

  before_create do
    self.end_time = self.date_time + self.services.first.duration.to_i * 60
  end

end
