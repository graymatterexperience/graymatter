class Admin::ApplicationController < ActionController::Base
  # TODO need to fix this
  protect_from_forgery with: :null_session
  # protect_from_forgery with: :exception
  include SessionsHelper

  def authorize
    alert_message = 'You must be logged in'
    #unless logged_in? redirect_to login_path, alert: alert_message; end
    redirect_to login_path, alert: alert_message if !logged_in?
    #redirect_to login_path if !logged_in?
  end

  def admin_authorize
    if !authorize
      if !current_user.admin?
        redirect_to root_path, alert: 'This operation not allowed'
      end
    end
  end
end
