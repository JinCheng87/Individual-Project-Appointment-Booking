class CronJobsController < ApplicationController
  def send_message
    # UserMailer.confirm_appointment(Appointment.last).deliver_now
    puts 'hello world'
  end
end