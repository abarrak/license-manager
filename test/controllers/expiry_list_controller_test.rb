require "test_helper"

class ExpiryListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get expiry_list_index_url
    assert_response :success
  end
end
