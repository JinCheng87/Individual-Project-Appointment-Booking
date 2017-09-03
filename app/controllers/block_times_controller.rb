class BlockTimesController < ApplicationController
  def create
    find_staff
    start_time = Time.parse(params[:start_time])
    end_time = start_time + 30.minutes
    if !@staff.is_blocked(start_time).any?
      @staff.block_times.create!(start_time: start_time, end_time: end_time)
    end
  end

  def destroy
    find_staff
    @block_time = BlockTime.find(params[:block_time_id])
    go_time = @block_time[0].start_time
    @block_time[0].destroy
    redirect_to store_schedule_path(@staff.store_id, go_time.strftime('%Y-%m-%d'))
  rescue ActiveRecord::RecordNotFound
    render '/error/not_found'
  end

  private

  def find_staff
    @staff = Staff.find(params[:id])
  end
end