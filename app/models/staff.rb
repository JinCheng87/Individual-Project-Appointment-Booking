class Staff < ApplicationRecord
  has_many :appointments

  def available(time)
    date = Date.today
    appointments.each do |appointment|
      if appointment.date == date && appointment.time.hour == time
        return false
      end
    end
    true
  end
end
