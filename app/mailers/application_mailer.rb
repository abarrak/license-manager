class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.x.email.sender
  layout "mailer"

  helper :application
  helper :licenses
end
