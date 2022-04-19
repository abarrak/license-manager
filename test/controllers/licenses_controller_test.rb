require "test_helper"

class LicensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @license = licenses(:one)
    @sample_params = { license: { renewal_times: 7, title: "New SQL 2022" } }
  end

  test "should give the licenses index correctly" do
    get licenses_url
    assert_response :success
    assert_template 'index'
    License.all.each do |post|
      assert_select "a[href=?]", license_path(post)
    end
  end

  test "should get new page" do
    get new_license_url
    assert_response :success
    assert_template :new
  end

  test "successful create with correct credentials and data" do
    assert_difference("License.count") do
      post licenses_url, params: {
        license: {
          current_expire_date: "2025-1-1", description: "AWS Subscription",
          owner: "SRE", renewal_times: 0, title: "AWS"
        }
      }
    end
    new_license = License.last
    assert_redirected_to license_url(new_license)
    assert_equal "AWS", new_license.title
    assert_equal 0, new_license.renewal_times
    assert_equal "SRE", new_license.owner
    assert_nil new_license.owner_email
  end

  test "should display license page when show is clicked" do
    get license_url(@license)
    assert_response :success
    assert_template :show
  end

  test "should get the editing page for a license" do
    get edit_license_url(@license)
    assert_response :success
    assert_template :edit
  end

  test "successful update with correct credentials and data" do
    patch license_url(@license), params: @sample_params
    assert_redirected_to license_url(@license)
    assert_not flash[:notice].empty?

    @license.reload
    assert_equal @license.title, @sample_params[:license][:title]
    assert_equal @license.renewal_times, @sample_params[:license][:renewal_times]
  end

  test "successful destroy with correct credentials and data" do
    assert_difference "License.count", -1 do
      delete license_url(@license)
    end

    assert_redirected_to licenses_url
    assert_not_empty flash[:notice]
  end
end
