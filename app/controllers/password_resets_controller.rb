class PasswordResetsController < ApplicationController
  respond_to :html, :json

  def new
    @page_title = 'Reset Password'
    @user = User.new
    puts ' * controller 1' * 5
    respond_modal_with @user
  end

  def create 
    binding.pry

  end
end
