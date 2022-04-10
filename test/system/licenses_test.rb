require "application_system_test_case"

class LicensesTest < ApplicationSystemTestCase
  setup do
    @license = licenses(:one)
  end

  test "visiting the index" do
    visit licenses_url
    assert_selector "h1", text: "Licenses"
  end

  test "should create license" do
    visit licenses_url
    click_on "New license"

    fill_in "Current expire date", with: @license.current_expire_date
    fill_in "Description", with: @license.description
    fill_in "Owner", with: @license.owner
    fill_in "Renewal times", with: @license.renewal_times
    fill_in "Title", with: @license.title
    click_on "Create License"

    assert_text "License was successfully created"
    click_on "Back"
  end

  test "should update License" do
    visit license_url(@license)
    click_on "Edit this license", match: :first

    fill_in "Current expire date", with: @license.current_expire_date
    fill_in "Description", with: @license.description
    fill_in "Owner", with: @license.owner
    fill_in "Renewal times", with: @license.renewal_times
    fill_in "Title", with: @license.title
    click_on "Update License"

    assert_text "License was successfully updated"
    click_on "Back"
  end

  test "should destroy License" do
    visit license_url(@license)
    click_on "Destroy this license", match: :first

    assert_text "License was successfully destroyed"
  end
end
