namespace :reminder do
  desc "Rake task to sent a email to reminder customer appointment"
  task fetch: :environment do
    UserMailer.confirm_appointment(Appointment.last).deliver_now
  end
end
# appointments = []
# Store.all.each do|store|
#   appointments = store.appointments.where("date_time <= :three_hours_prior AND date_time <= :end_of_day",{begin_of_day: begin_day, end_of_day: end_day})
# end