class ApplicationController < ActionController::Base
	include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    if resource.role.project_manager?
    	projects_path
    else
    	developer_dashboard_user_path(current_user)
    end
  end

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_in) << :role
  end

  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
