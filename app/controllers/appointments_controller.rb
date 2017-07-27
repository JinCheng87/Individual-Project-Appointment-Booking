class AppointmentsController < ApplicationController
  before_action :find_store
  def new
    @appointment = @store.appointments.new
  end

  private
  def find_store
    @store = Store.find_by(id: params[store_id])
  end
end