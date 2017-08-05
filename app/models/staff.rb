class Staff < ApplicationRecord
  resourcify
  has_many :appointments
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :store_id, presence: true
  
  def available(date, hour, minute)
    calendar_date = Time.zone.parse("#{date}+ #{hour.to_s}:#{minute.to_s}")
    appointments.each do |appointment|
      if appointment.date_time.strftime('%Y-%m-%d') == date #for less database query
        if calendar_date.between?(appointment.date_time-600, appointment.end_time+600) #10mins before or after appointment 
          return false
        end
      end
    end
    true
  end

  def available_between(start_time, end_time)
    appointments.each do |appointment|
      return false if appointment.date_time.between?(start_time, end_time) || appointment.end_time.between?(start_time, end_time)
    end
    true
  end

  def find_appointment(date, time)
    calendar_date = Time.zone.parse("#{date}+ #{time}")
    appointments.each do |appointment|
      if appointment.date_time.strftime('%Y-%m-%d') == date #for less database query
        if calendar_date.between?(appointment.date_time, appointment.end_time) 
          return appointment
        end
      end
    end
  end
end
