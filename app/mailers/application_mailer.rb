class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@graymatter.com'  # not sure what they want this to be... will change
  layout 'mailer'
end
