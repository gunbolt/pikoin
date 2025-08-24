require "test_helper"

class PeriodTest < ActiveSupport::TestCase
  test "#range" do
    travel_to Date.new(2025, 4, 15) do
      period = Period.coerce("tm")
      assert_equal Date.new(2025, 4, 1)..Date.new(2025, 4, 30), period.range

      period = Period.coerce("lm")
      assert_equal Date.new(2025, 3, 1)..Date.new(2025, 3, 31), period.range

      period = Period.coerce("ty")
      assert_equal Date.new(2025, 1, 1)..Date.new(2025, 12, 31), period.range

      period = Period.coerce("ly")
      assert_equal Date.new(2024, 1, 1)..Date.new(2024, 12, 31), period.range

      period = Period.coerce("7d")
      assert_equal Date.new(2025, 4, 8)..Date.new(2025, 4, 15), period.range

      period = Period.coerce("30d")
      assert_equal Date.new(2025, 3, 16)..Date.new(2025, 4, 15), period.range

      period = Period.coerce("3m")
      assert_equal Date.new(2025, 1, 15)..Date.new(2025, 4, 15), period.range

      period = Period.coerce("6m")
      assert_equal Date.new(2024, 10, 15)..Date.new(2025, 4, 15), period.range

      period = Period.coerce("12m")
      assert_equal Date.new(2024, 4, 15)..Date.new(2025, 4, 15), period.range

      period = Period.coerce("24m")
      assert_equal Date.new(2023, 4, 15)..Date.new(2025, 4, 15), period.range

      period = Period.coerce("all")
      assert_nil period.range
    end
  end
end
