class HomeController < ApplicationController
  # before_action :authenticate_client!
  def index
    @staffs = Staff.all
    render :'appointments/admin_side_calendar'
  end
end