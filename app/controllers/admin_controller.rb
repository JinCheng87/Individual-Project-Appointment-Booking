class AdminController < ApplicationController
  before_action :authenticate_admin

  def show_calendars
    @stores = Store.all
    @store = Store.find_by(id: params[:store_id])
    @appointments_array = []
    Store.all.each_with_index do |store,index|
      begin_day = Time.zone.parse(params[:id]).beginning_of_day
      end_day = Time.zone.parse(params[:id]).end_of_day
      @appointments_array[index] = store.appointments.where("date_time >= :begin_of_day AND date_time <= :end_of_day",{begin_of_day: begin_day, end_of_day: end_day}).count
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