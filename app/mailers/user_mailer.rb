class UserMailer < ApplicationMailer
  default from: 'Appt-booking'

  def confirm_appointment(appointment)
    @appointment = appointment
    mail(to: @appointment.email, subject:'Appointment confirmation')
  end

  def modify_appointment(appointment)
    @appointment = appointment
    mail(to: @appointment.email, subject:'Appointment changed')
  end

  def cancel_appointment(appointment)
    @appointment = appointment
    mail(to: @appointment.email, subject:'Appointment cancelled')
  end

  def remind_appointment(appointment)
    @appointment = appointment
    mail(to: @appointment.email, subject:'Appointment comming up')
  end
end