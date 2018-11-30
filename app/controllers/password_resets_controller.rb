class PasswordResetsController < ApplicationController
  respond_to :html, :json

  def new
    @page_title = 'Reset Password'
    @user = current_user
    #respond_modal_with @user
  end

  def update 
    @page_title = 'Reset Password'
    @user = current_user
    @user.user_information["sign_in_count"] = 0
    if @user.update_attributes(password_params)
      flash[:success] = "#{@user.name.capitalize}, Your password has been updated"
      redirect_to home_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end
end
