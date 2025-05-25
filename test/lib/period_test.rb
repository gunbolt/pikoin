require "test_helper"

class PeriodTest < ActiveSupport::TestCase
  test "#range" do
    travel_to Date.new(2025, 4, 15) do
      period = Period.for("tm")
      assert_equal Date.new(2025, 4, 1)..Date.new(2025, 4, 30), period.range

      period = Period.for("lm")
      assert_equal Date.new(2025, 3, 1)..Date.new(2025, 3, 31), period.range

      period = Period.for("ty")
      assert_equal Date.new(2025, 1, 1)..Date.new(2025, 12, 31), period.range

      period = Period.for("ly")
      assert_equal Date.new(2024, 1, 1)..Date.new(2024, 12, 31), period.range

      period = Period.for("7d")
      assert_equal Date.new(2025, 4, 8)..Date.new(2025, 4, 15), period.range

      period = Period.for("1m")
      assert_equal Date.new(2025, 3, 15)..Date.new(2025, 4, 15), period.range

      period = Period.for("3m")
      assert_equal Date.new(2025, 1, 15)..Date.new(2025, 4, 15), period.range

      period = Period.for("6m")
      assert_equal Date.new(2024, 10, 15)..Date.new(2025, 4, 15), period.range

      period = Period.for("1y")
      assert_equal Date.new(2024, 4, 15)..Date.new(2025, 4, 15), period.range

      period = Period.for("2y")
      assert_equal Date.new(2023, 4, 15)..Date.new(2025, 4, 15), period.range

      period = Period.for("all")
      assert_nil period.range
    end
  end
end
