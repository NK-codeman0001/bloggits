class ApplicationController < ActionController::Base
  include Pagy::Backend
  serialization_scope :view_context
  before_action :configure_permitted_parameters, if: :devise_controller?


protected
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
  devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  devise_parameter_sanitizer.permit(:account_update, keys: [:username])
end 
end
