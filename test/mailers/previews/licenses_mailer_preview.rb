# Preview all emails at http://localhost:3000/rails/mailers/licenses_mailer
class LicensesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/licenses_mailer/expired
  def expired
    LicensesMailer.expired License.first
  end
end
