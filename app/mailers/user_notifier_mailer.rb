class UserNotifierMailer < ApplicationMailer
  default from: 'troyleach@outlook.com' # TODO fix me

  def send_signup_email(user)
    @user = user
    @url_path = ENV['EMAIL_LOGIN_PATH']
    @generated_password = user.password
    attachments.inline['main-logo.png'] = File.read('./app/assets/images/main-logo.png')
    attachments.inline['brain_logo.png'] = File.read('./app/assets/images/brain_logo.png')
    attachments.inline['facebook3232.png'] = File.read('./app/assets/images/facebook3232.png')
    attachments.inline['instagram3232.png'] = File.read('./app/assets/images/instagram3232.png')
    attachments.inline['linkedin3232.png'] = File.read('./app/assets/images/linkedin3232.png')
    attachments.inline['twitter3232.png'] = File.read('./app/assets/images/twitter3232.png')

    mail(to: @user.email,
         subject: 'Welcome to the Gray Matter Experience')
  end
end
