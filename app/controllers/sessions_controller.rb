class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Welcome #{user.first_name}"
      redirect_to home_path
    else
      #create an error message
      flash.now[:danger] = 'invalid email/password combination'  # not working
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You have logged out"
    redirect_to root_url
  end
end
