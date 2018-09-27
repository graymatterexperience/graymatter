class Admin::UsersController < Admin::ApplicationController
  def new
    @page_title = 'Add a Student'
    @user = User.new
  end

  def create
    @page_title = 'All Students'
   end

  def edit; end

  def update; end

  def destroy; end

  def index
    @show_buttons = false
    @page_title = 'All Students'
    @students = User.all
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
