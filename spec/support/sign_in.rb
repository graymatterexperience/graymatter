module SignIn
  def sign_in_user(user)
    sign_in = User.where(id: user.id)
    request.session[:user] = sign_in
  end
end
