namespace :clean_appointment do
  desc "Delete all the appointments that are 6 month old"
  task clean: :environment do
    appointments = []
    Store.all.each do|store|
      appointments << store.appointments.where("date_time <= :six_month_before",{six_month_before: Time.zone.now - 6.months})
    end

    appointments.flatten.each do |appointment|
      @appointment = appointment
      @appointment.destroy
    end
  end
end