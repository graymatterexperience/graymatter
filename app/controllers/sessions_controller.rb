class SessionsController < ApplicationController
  def new
    puts ' * sessions controller 1' * 3
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Welcome #{user.first_name}"
      redirect_to home_url
    else
      #create an error message
      flash.now[:error] = 'invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    user = User.find_by_id(session["user_id"])
    user.user_information["sign_in_count"] += 1 if user.user_information["sign_in_count"]
    user.save(validate: false)
    session.delete(:user_id)
    redirect_to login_path, alert: "You have successfully logged out."
  end
end
