class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Use callbacks to share common setup or constraints between actions.
  def set_vault
    @vault = params[:vault_id] ? Vault.find_by_id(params[:vault_id]) : Vault.find_by_id(params[:id])
    redirect_to root_url if @vault.nil? || @vault.user_username != params[:username]
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :username, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :username, :full_name, :bio, :url, :password, :password_confirmation, :current_password)}
    end
end