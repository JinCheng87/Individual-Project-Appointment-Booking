class EmailNewAppointentJob < ApplicationJob
  queue_as :default

  def perform(appointment)
  end
end
