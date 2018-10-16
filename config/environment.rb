# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
    :user_name => 'britney_robbins',
    :password => 'graymatter1',
    :domain => 'staging-graymatter.herokuapp.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  } 


#   ActionMailer::Base.smtp_settings = {
#     :user_name => ENV["SENDGRID_USERNAME"],
#     :password => ENV["SENDGRID_PASSWORD"],
#     :domain => 'production-gray-matter.herokuapp.com',
#     :address => 'smtp.sendgrid.net',
#     :port => 587,
#     :authentication => :plain,
#     :enable_starttls_auto => true
#   }
  