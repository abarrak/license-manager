require "test_helper"

class LicenseExpiryTest < ActiveSupport::TestCase
  def setup
    @record = license_expiries(:one)
  end

  test "expires are calculated for all the licenses and cached in own tables" do
    assert_nil @record.days_count
    LicenseExpiry.calculate_all_expiries!

    @record.reload
    assert_not_nil @record.days_count
    assert_kind_of Integer, @record.days_count
  end

  test "ensure days_count is updated upon calcuate run" do
    assert_difference @record.days_count do
      LicenseExpiry.calculate_all_expiries!
    end
  end
end
