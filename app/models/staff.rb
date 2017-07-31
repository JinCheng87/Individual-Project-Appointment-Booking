class Staff < ApplicationRecord
  resourcify
  has_many :appointments

  def available(date, hour, minute)
    new_date = DateTime.parse(date)
    calendar_date = DateTime.new(new_date.year, new_date.month, new_date.day, hour, minute)
    appointments.each do |appointment|
      if appointment.date_time.strftime('%Y-%m-%d') == date #for less database query, cut time to half
        if calendar_date.between?(appointment.date_time-600, appointment.date_time + appointment.services.first.duration.to_i*60+600) #10mins before or after appointment 
          return false
        end
      end
    end
    true
  end

  def find_appointment(date, hour, minute)
    new_date = DateTime.parse(date)
    calendar_date = DateTime.new(new_date.year, new_date.month, new_date.day, hour, minute)
    appointments.each do |appointment|
      if calendar_date.between?(appointment.date_time, appointment.date_time + appointment.services.first.duration.to_i*60)
        return appointment
      end
    end
  end
end
