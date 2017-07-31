class AppointmentsController < ApplicationController
  before_action :find_store, except: [:customer_appointments]
  before_action :find_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_current_user, only: [:edit, :destroy, :update]
  def index
    authenticate_admin
    @appointments = Appointment.all

  end

  def new
    @staffs = @store.staffs.all
    @services = Service.all
    if current_user
      if current_user.has_role? :customer
        @appointment = current_user.appointments.new(name: current_user.name, phone_number: current_user.phone_number, email: current_user.email, store_id: @store.id, staff_id: params[:staff_id], date_time: params[:date_time])
      end
    else
        @appointment = @store.appointments.new(staff_id: params[:staff_id], date_time: params[:date_time])
    end
  end

  def create
    @appointment = @store.appointments.new(appointment_params)
    # if @appointment.staff.available_between(@appointment.date_time, @appointment.endtime)
    if @appointment.save
      redirect_to store_appointment_path(@store,@appointment)
    else
      render :new
    end
  end

  def show
  end

  def staff_appointments
    #needs store_id because into individule appointment needs it
    authenticate_admin
    @staff = Staff.find(params[:id]) 
    @appointments = @staff.appointments.all
  end

  def customer_appointments
    authenticate_user!
    @current_user = current_user
    @appointments = current_user.appointments.all
  end

  def edit
    redirect_to '/404' unless is_admin || current_user.id == @appointments.user_id
      @services = Service.all
      @staffs = @store.staffs.all
  end

  def update
    redirect_to '/404' unless is_admin || current_user.id == @appointment.user_id
    if @appointment.update_attributes(appointment_params)
      redirect_to store_appointment_path(@store,@appointment)
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to store_appointments_path(@store)
  end

  private
  def find_store
    @store = Store.find_by(id: params[:store_id])
  end

  def find_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    app_params = params.require(:appointment).permit(:date_time, :name, :email, :phone_number, :staff_id, :user_id, :store_id, :service_ids)
    if current_user
      app_params.merge(user_id: current_user.id) if current_user.has_role? :customer
    end
    app_params
  end
end