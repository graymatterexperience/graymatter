# Preview all emails at http://localhost:3000/rails/mailers/user_notifier
class UserNotifierPreview < ActionMailer::Preview
  def send_signup_email
    user = User.all.sample
    UserNotifierMailer.send_signup_email(user)
  end
end
