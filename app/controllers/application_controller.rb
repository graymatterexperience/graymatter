class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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

  #def respond_modal_with(*args, &blk)
  # I could not get the validations to work
    #options = args.extract_options!
    #options[:responder] = ModalResponder
    #puts ' * application controller 3' * 3
    #respond_with *args, options, &blk
  #end

end
