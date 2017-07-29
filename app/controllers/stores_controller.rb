class StoresController < ApplicationController
  before_action :find_store, except: [:new, :create, :index]
  def index
    @stores = Store.all
  end

  def show 
    @is_admin = is_admin   
  end

  def edit
    authenticate_user!
    if !is_admin
      render :'errors/not_found'
    else
      render :edit
    end
  end

  def update
    authenticate_user!
    if !is_admin
      render :'errors/not_found'
    else
      if @store.update_attributes(store_params)
        redirect_to @store
      else
        render :edit
      end
    end
  end

  private

  def store_params
    params.require(:store).permit(:location, :hours, :name, :description)
  end

  def find_store
    @store = Store.find(params[:id])
  end

  def is_admin
    if current_user
      return true if current_user.has_role? :admin
    end
    false
  end

end

