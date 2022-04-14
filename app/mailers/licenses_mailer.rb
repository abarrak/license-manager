class LicensesMailer < ApplicationMailer
  MAIN_COPIED = Rails.application.config.x.email.main_cc

  def expired license
    @license = license
    mail to: license.owner_email, cc: MAIN_COPIED,
         subject: default_i18n_subject(title: @license.title)
  end
end
