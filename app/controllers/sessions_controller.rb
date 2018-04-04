class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to root_path 
    else
      #create an error message
      flash.now[:danger] = 'invalid email/password combination'  # not working
      render 'new'
    end
  end
end
