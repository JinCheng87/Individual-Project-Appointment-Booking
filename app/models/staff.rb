class Staff < ApplicationRecord
  has_many :appointments

  def available(date, time)
    appointments.each do |appointment|
      if appointment.date == Date.parse(date) && appointment.time.hour == time.to_i
        return false
      end
    end
    true
  end

  def find_appointment(date, time)
    appointments.each do |appointment|
      if appointment.date == Date.parse(date) && appointment.time.hour == time.to_i
        return appointment
      end
    end
  end
end
