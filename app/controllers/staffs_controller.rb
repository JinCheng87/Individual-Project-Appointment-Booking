class StaffsController < ApplicationController
  before_action :find_store
  before_action :find_staff, except: [:new, :create, :index]
  before_action :authenticate_admin, except: [:show, :index]

  def new
      @staff = Staff.new
      render :new
  end

  def create
    @staff = @store.staffs.new(staff_params)
    if @staff.save
      redirect_to store_staff_path(@store,@staff), notice: 'empolyee created successfully'
    else
      render :new
    end
  end

  def show
  end

  def index
    @is_admin = is_admin
    @staffs = @store.staffs.all
  end

  def edit
  end

  def update
    if @staff.update_attributes(staff_params)
      redirect_to store_staff_path(@store, @staff), notice: 'empolyee updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @staff.destroy
    redirect_to show_empolyees_path, notice: 'empolyee deleted successfully'
  end

  private

  def find_store
    @store = Store.find_by(id: params[:store_id])
  rescue ActiveRecord::RecordNotFound
    render 'errors/not_found'
  end

  def find_staff
    @staff = Staff.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'errors/not_found'
  end

  def staff_params
    params.require(:staff).permit(:name, :phone_number)
  end
end