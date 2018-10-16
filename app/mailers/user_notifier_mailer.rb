class UserNotifierMailer < ApplicationMailer
  default from: 'troyleach@outlook.com' # TODO fix me

  def send_signup_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Your new Gray Matter Experience')
  end
end
