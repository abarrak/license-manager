require "test_helper"

class OpTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def setup
    stub_requests
  end

  test "#clear_all clean up all licenses and expiries" do
    assert License.count > 0
    assert LicenseExpiry.count > 0

    assert_difference -> { License.count } => -License.count do
      Ops.clear_all
    end

    assert_equal 0, License.count
    assert_equal 0, LicenseExpiry.count
  end

  def stub_requests
    stub_request(
      :any, -> (uri) { uri.to_s.starts_with? "https://example.com" }
    ).to_return status: 200, body: ""
  end
end
