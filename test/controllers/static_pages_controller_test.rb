require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get root_url
    assert_response :success
    assert_template 'main'
    assert_select 'title', page_title
  end

  test 'should get about' do
    get about_url
    assert_response :success
    assert_template 'about'
    assert_select 'title', page_title('About')
  end

  test 'should get contact' do
    get contact_url
    assert_response :success
    assert_template 'contact'
    assert_select 'title', page_title('Contact')
  end
end
