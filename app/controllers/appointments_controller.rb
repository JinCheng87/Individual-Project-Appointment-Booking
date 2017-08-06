class AppointmentsController < ApplicationController
  before_action :find_store, except: [:customer_appointments]
  before_action :find_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_token, only: [:show, :edit, :update, :destroy]

  def new
    @staffs = @store.staffs.all
    @services = Service.all
    if current_user
      if current_user.has_role? :customer
        @appointment = current_user.appointments.new(name: current_user.name, phone_number: current_user.phone_number, email: current_user.email, store_id: @store.id, staff_id: params[:staff_id], date_time: Time.zone.now)
      else
         @appointment = @store.appointments.new(staff_id: params[:staff_id], date_time: params[:date_time])
      end
    else
      @appointment = @store.appointments.new(staff_id: params[:staff_id], date_time: Time.zone.now)
    end
  end

  def create
    @staffs = @store.staffs.all
    @services = Service.all
    @appointment = @store.appointments.new(appointment_params)
    if @appointment.staff.available_between(@appointment.date_time, @appointment.endtime)
      if @appointment.date_time < DateTime.now
        flash.now[:notice] = "So you wanna make a reservation for the past?"
        render :new
        return
      end
      if @appointment.save
        redirect_to store_appointment_path(@store,@appointment,token: @appointment.token), notice: 'Appointment created successfully'
        UserMailer.confirm_appointment(@appointment).deliver_later
      else
        render :new
      end
    else
      flash.now[:notice]= "#{@appointment.staff.name} is not available in this time, please select another session"
      render :new
    end
  end

  def show
  end

  def staff_appointments
    #needs store_id because into individule appointment needs it
    authenticate_admin
    @staff = Staff.find(params[:id]) 
    @appointments = @staff.appointments.where("date_time >= :time",{time: Time.zone.now}).order(date_time: :asc)
  end

  def customer_appointments
    authenticate_user!
    @current_user = current_user
    @appointments = current_user.appointments.where("date_time >= :time",{time: Time.zone.now}).order(date_time: :asc)
  end

  def edit
      @services = Service.all
      @staffs = @store.staffs.all
  end

  def update
    if @appointment.update_attributes(appointment_params)
      redirect_to store_appointment_path(@store,@appointment,token: params[:token]), notice: 'Appointment updated successfully'
      UserMailer.modify_appointment(@appointment).deliver_now
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to store_path(@store), notice: 'Appointment cancelled successfully'
    UserMailer.cancel_appointment(@appointment).deliver_now
  end

  private
  def find_store
    @store = Store.find_by(id: params[:store_id])
  end

  def authenticate_token
    authenticate_user! unless @appointment.token == params[:token]
    if current_user 
      redirect_to '/404' unless is_admin || authenticate_current_user
    end
  end

  def find_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    app_params = params.require(:appointment).permit(:date_time, :name, :email, :phone_number, :staff_id, :user_id, :store_id, :service_ids, :time_zone)
    if current_user
      app_params.merge!(user_id: current_user.id) if current_user.has_role? :customer
    end
    app_params
  end
end