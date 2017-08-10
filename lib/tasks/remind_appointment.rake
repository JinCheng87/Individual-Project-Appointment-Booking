namespace :reminder do
  desc "Rake task to sent a email to reminder customer appointment"
  task fetch: :environment do
    UserMailer.confirm_appointment(Appointment.last).deliver_now
    # puts 'hello world'
  end
end
    # puts "#{Time.now} - Success!"
#   end
# end