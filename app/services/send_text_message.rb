class SendTextMessage
  def initialize(phone_number,body)
    @phone_number = phone_number
    @body = body
  end

  def send_message
    client = Twilio::REST::Client.new
    client.messages.create({
    from: Rails.application.secrets.twilio_phone,
    to: @phone_number, # your sign up phone number
    body: @body,
    })
  end
end