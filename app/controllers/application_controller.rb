class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  # Use callbacks to share common setup or constraints between actions.
  def set_vault
    @vault = params[:vault_id] ? Vault.find_vault(params[:vault_id]) : Vault.find_vault(params[:id])
  end

  def authenticate_username
    user = User.find_by_username(params[:username])
    redirect_to root_url if user.nil? || user.vaults.find_vault(params[:vault_id]).nil?
  end

  def check_edit_permissions
    if @vault.user_id != current_user.id then
      flash[:alert] = t(:permissions_error)
      redirect_to root_url
    end
  end

  def check_show_permissions
    if !user_signed_in? || @vault.user_id != current_user.id
      if @vault.exposure == "private_vault"
        flash[:alert] = t(:permissions_error)
        redirect_to @vault
      end
    end
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :username, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :username, :full_name, :bio, :url, :password, :password_confirmation, :current_password)}
    end
end