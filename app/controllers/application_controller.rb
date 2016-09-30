class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

before_action :set_last_seen_at, if: proc { user_signed_in? }
  before_action :authenticate_user!
before_action :configure_permitted_parameters, if: :devise_controller?
    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end


private
def set_last_seen_at
  current_user.update_attribute(:last_seen_at, Time.now)
end

end
