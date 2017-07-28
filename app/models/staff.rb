class Staff < ApplicationRecord
  has_many :appointments

  def available(date, time)
    appointments.each do |appointment|
      if appointment.date == Date.parse(date) && appointment.time.hour == time
        return false
      end
    end
    true
  end
end
