class AppointmentsController < ApplicationController
  before_action :find_store
  before_action :find_appointment, except: [:new, :create, :index, :staff_appointments]

  def index
    @appointments = Appointment.all

  end

  def new
    
    @staffs = @store.staffs.all
    @services = Service.all
    @appointment = @store.appointments.new(staff_id: params[:staff_id], time: params[:time], date: params[:date])
  end

  def create
    @staffs = @store.staffs.all
    @services = Service.all
    @appointment = @store.appointments.new(appointment_params)
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

    @appointments = Staff.find(params[:id]).appointments.all
  end

  def edit
    @services = Service.all
    @staffs = @store.staffs.all
  end

  def update
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
    params.require(:appointment).permit(:date, :time, :name, :email, :phone_number, :staff_id, :user_id, :store_id, :service_id)
  end
end