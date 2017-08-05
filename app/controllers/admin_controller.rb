class AdminController < ApplicationController

  def show_calendars
    @stores = Store.all
    @store = Store.find_by(id: params[:store_id])
    @appointments_array = []
    Store.all.each_with_index do |store,index|
      
      @appointments_array[index] = store.appointments.where("date_time = ?",params[:id]).count
    end
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