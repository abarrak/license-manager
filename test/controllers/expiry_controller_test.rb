require "test_helper"

class ExpiryControllerTest < ActionDispatch::IntegrationTest
  test "fetches expired page successfully" do
    get expired_url
    assert_response :success
    assert_template :expired
  end

  test "fetches stats page successfully" do
    get stats_url
    assert_response :success
    assert_template :stats
  end
end
