class EmailCancelAppointmentJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    UserMailer.cancel_appointment(appointment).deliver_now
  end
end
