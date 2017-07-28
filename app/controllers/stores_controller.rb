class StoresController < ApplicationController
  before_action :find_store, except: [:new, :create, :index]
  def index
  end

  def new
    store = Store.new
    render :new, locals: { store: store}
  end

  def create
    store = Store.new(store_params)
    if store.save
      redirect_to store
    else
      render :new, locals: { store: @store }
    end
  end

  def show    
  end

  def edit
  end

  def update
    if @store.update_attributes(store_params)
      redirect_to @store
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    redirect_to stores_path
  end

  private

  def store_params
    params.require(:store).permit(:location, :hours, :name, :description)
  end

  def find_store
    @store = Store.find(params[:id])
  end

end

