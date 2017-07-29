class ScheduleController < ApplicationController
  def show
    @store = Store.find_by(id: params[:store_id])
    @staffs = @store.staffs.all
    render :show, locals: {date: params[:id]}
  end
end