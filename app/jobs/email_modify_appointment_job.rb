class EmailModifyAppointmentJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    UserMailer.modify_appointment(appointment).deliver_now
  end
end
