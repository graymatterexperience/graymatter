class UsersController < ApplicationController
  respond_to :html, :json

  def update
    @user = User.find_by_id(params[:id])
    @user.user_information["sign_in_count"] = 0
    if @user.update_attributes(password_params)
      flash[:success] = "#{@user.name.capitalize} has been updated"
      respond_modal_with @user, location: root_path
      #redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end

  def set_user

  end
end


