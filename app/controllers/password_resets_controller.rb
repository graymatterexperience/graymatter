class PasswordResetsController < ApplicationController
  respond_to :html, :json

  def new
    @page_title = 'Reset Password'
    @user = current_user
    puts ' * controller 1' * 5
    puts @user.inspect
    respond_modal_with @user
  end

  def update 
    binding.pry
    #if @user.update_attributes(user_params)
      #flash[:success] = "#{@user.name.capitalize} has been updated"
      #redirect_to admin_users_path(user: @user.role)
    #else
      #flash[:error] = 'Something went wrong'
      #render 'edit'
    #end
  end

  private

  def password_params
    params.require(:password).permit(
      :password,
      :password_confirmation
    )
  end
end
