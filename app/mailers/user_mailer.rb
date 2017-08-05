class UserMailer < ApplicationMailer
  default from: 'Appt-booking'

  def confirm_appointment(appointment)
    @appointment = appointment
    mail(to: @appointment.email, subject:'Appointment confirmation')
  end
end