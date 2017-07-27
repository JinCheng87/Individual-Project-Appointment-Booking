class RegistraionsController < Devise::RegistraionsController
  private
  
  def sign_up_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end 

  def account_update_params
    params.require(:user).permit(:name, :email, :phone_number,:current_password, :password, :password_confirmation)
  end
end