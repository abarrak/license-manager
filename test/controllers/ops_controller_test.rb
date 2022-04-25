require "test_helper"

class OpsControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get dashboard_url
    assert_response :success
  end
end
