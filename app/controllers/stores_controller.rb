class StoresController < ApplicationController
  before_action :find_store, except: [:new, :create, :index]
  before_action :authenticate_admin, only: [:edit, :update, :edit_hours] 

  def show 
    @is_admin = is_admin   
  end

  def index
    @stores = Store.all
  end

  def edit
  end

  def update
    if @store.update_attributes(store_params)
      redirect_to show_stores_hours_path
    else
      render :edit
    end
  end

  private

  def store_params
    params.require(:store).permit(:location, :open_hour, :close_hour, :name, :description)
  end

  def find_store
    @store = Store.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'errors/not_found'
  end
end

