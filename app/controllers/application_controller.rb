class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def not_found
    redirect_to '/404'
  end
  def is_admin
    if current_user
      return true if current_user.has_role? :admin
    end
    false
  end
  def authenticate_admin
    authenticate_user!
    redirect_to '/404' if !is_admin
  end
end
