class Staff < ApplicationRecord
  resourcify
  has_many :appointments

  def round_minute(minute)
    if minute - 30 >= 0
      return 30
    else
      return 0
    end
  end

  def available(date, time, minute)
    appointments.each do |appointment|
      if appointment.date == Date.parse(date) && appointment.time.hour == time.to_i && round_minute(appointment.time.strftime('%M').to_i) == minute
        return false
      end
    end
    true
  end

  def find_appointment(date, time, minute)
    appointments.each do |appointment|
      if appointment.date == Date.parse(date) && appointment.time.hour == time.to_i && round_minute(appointment.time.strftime('%M').to_i) == minute
        return appointment
      end
    end
  end
end
