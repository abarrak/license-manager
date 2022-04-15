require "test_helper"

class ExpiryCalculatorTest < ActiveSupport::TestCase
  def setup
    @calcuator = ExpiryCalculator.new
    @test_data = {
      one_day: DateTime.now + 1,
      two_day: DateTime.now + 2,
      three_months: Date.today + 90,
      one_year: Date.parse((Date.today + 365).to_s)
    }
  end

  test "calculate difference in days for current and future expiry date" do
    assert_in_delta 1, @calcuator.calculate(@test_data[:one_day]), 1
    assert_in_delta 2, @calcuator.calculate(@test_data[:two_day]), 1
    assert_equal 90, @calcuator.calculate(@test_data[:three_months])
    assert_equal 365, @calcuator.calculate(@test_data[:one_year])
  end

  test "handles expired dates correctly" do
    assert_equal 0, @calcuator.calculate(Date.yesterday)
  end
end
