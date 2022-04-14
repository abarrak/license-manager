require "test_helper"

class LicensesMailerTest < ActionMailer::TestCase
  def setup
    @license = licenses(:one)
  end

  test "expired" do
    mail = LicensesMailer.expired @license
    assert_equal I18n.t('.licenses_mailer.expired.subject', title: @license.title), mail.subject
    assert_equal [@license.owner_email], mail.to
    assert_equal ["sre@example.com"], mail.from
    assert_match /Notice/, mail.body.encoded
  end
end
