class AdminController < ApplicationController
  def index
    authenticate_admin
    @stores = Store.all
    @store = Store.find_by(id: params[:store_id])
  end

  def show_calendars
    @store = Store.find_by(id: params[:store_id])
    @staffs = @store.staffs.all
    render :show_calendars, locals: {date: params[:id]}
  end

  def show_employees
    @stores = Store.all
  end

  def show_appointments
    authenticate_admin
    @appointments_array = [] #put all the available array inside this 2d array
    Store.all.each do |store|
      @appointments_array << store.appointments.where("date_time >= :time",{time: Time.zone.now}).order(date_time: :asc)
    end
  end

  def show_stores
    @stores = Store.all
  end

  def show_services
    @services = Service.all
  end
end