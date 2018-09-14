module SignIn
  def sign_in_user(user)
    request.session[:user_id] = user.id
  end
end
