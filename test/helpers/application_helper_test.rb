require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "page_title tests" do
    subtitle = 'Any title'
    base_title = BASE_TITLE

    assert_equal base_title, page_title
    assert_equal "#{subtitle} • #{base_title}", page_title(subtitle)
  end
end