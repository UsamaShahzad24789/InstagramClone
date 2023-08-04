# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.smtp_settings={
  address: 'smtp.gmail.com',
  port: 456,
  domain: 'gmail.com',
  username: ENV['usama.shahzad@recursolabs.com'],
  password: ENV['UsamaShahzad24789'],
  authentication: 'plain',
  :ssl => true,
  :tsl => true,
  enable_sharttls_auto: true
}
