namespace :reminder do
  desc "Rake task to sent a email to reminder customer appointment"
  task fetch: :environment do
    appointments = []
    Store.all.each do|store|
      appointments << store.appointments.where("date_time >= :five_hours_prior AND date_time <= :time_now AND has_been_reminded = false",{five_hours_prior: Time.zone.now-5.hours, time_now: Time.zone.now})
      appointments.each do |appointment|
        UserMailer.remind_appointment(appointment).deliver_now
        appointment.has_been_reminded = true
      end
    end
  end
end