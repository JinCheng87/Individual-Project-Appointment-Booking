class StoresController < ApplicationController
  def index
  end

  def new
    store = Store.new
    render :new, locals: { store: store}
  end

  def create
    store = Store.new(store_params)
    if store.save
      redirect_to :store
    else
      render :new, locals: { store: store}
    end
  end

  private

  def store_params
    params.require(:)
  end

end

