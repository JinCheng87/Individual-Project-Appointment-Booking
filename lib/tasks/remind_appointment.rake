namespace :reminder do
  desc "Rake task to sent a email to reminder customer appointment"
  task fetch: :environment do
    appointments = []
    Store.all.each do|store|
      appointments << store.appointments.where("date_time <= :five_hours_prior AND date_time >= :time_now AND has_been_reminded = false",{five_hours_prior: Time.zone.now + 5.hours, time_now: Time.zone.now})
    end
    
    appointments.flatten.each do |appointment|
      @appointment = appointment
      body = "This is a reminder that you having an appointment with us at #{@appointment.start_time}, if you would like to cancel, please call us #{@appointment.store.phone_number}. Thank you!"
      service = SendTextMessage.new('+16469155917',body)
      service.send_message
      @appointment.update_attributes(has_been_reminded: true)
    end
  end
end