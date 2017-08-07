class EmailConfirmAppointmentJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    UserMailer.confirm_appointment(appointment).deliver_now
  end
end
