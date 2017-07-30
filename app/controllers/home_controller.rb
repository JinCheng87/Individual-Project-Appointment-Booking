class HomeController < ApplicationController
  # before_action :authenticate_client!
  def index
    @is_customer = !is_admin
  end
end