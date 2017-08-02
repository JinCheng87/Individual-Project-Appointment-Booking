class Appointment < ApplicationRecord
  resourcify
  belongs_to :staff
  belongs_to :store
  has_and_belongs_to_many :services
  
  validates :date_time, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :staff_id, presence: true
  validates :store_id, presence: true

  def endtime
    date_time + services.first.duration.to_i * 60
  end

  before_create do
    self.end_time = self.date_time + self.services.first.duration.to_i * 60
  end

end
