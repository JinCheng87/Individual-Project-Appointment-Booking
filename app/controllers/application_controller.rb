class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_filter :user_time_zone, if: :current_user

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def not_found
    render 'errors/not_found'
  end

  def is_admin
    if current_user
      return true if current_user.has_role? :admin
    end
    false
  end

  def authenticate_admin
    authenticate_user!
    render 'errors/not_found' if !is_admin
  end

  def authenticate_current_user
    authenticate_user!
    render 'errors/not_found' unless is_admin || current_user.id == @appointment.user_id
  end
end
