require "test_helper"

class PeriodTest < ActiveSupport::TestCase
  test "year period" do
    period_2024 = Period.for("2024")

    assert_equal 12, period_2024.steps.size
    assert_equal Date.new(2024, 1, 1)..Date.new(2024, 1, 31),
      period_2024.steps.first
    assert_equal Date.new(2024, 12, 1)..Date.new(2024, 12, 31),
      period_2024.steps.last

    period_2026 = Period.for("2026")

    assert_equal 12, period_2026.steps.size
    assert_equal Date.new(2026, 1, 1)..Date.new(2026, 1, 31),
      period_2026.steps.first
    assert_equal Date.new(2026, 12, 1)..Date.new(2026, 12, 31),
      period_2026.steps.last
  end

  test "month period" do
    period_2025_04 = Period.for("2025-04")
    assert_equal 30, period_2025_04.steps.size
    assert_equal Date.new(2025, 4, 1), period_2025_04.steps.first
    assert_equal Date.new(2025, 4, 30), period_2025_04.steps.last

    period_2025_02 = Period.for("2025-02")
    assert_equal 28, period_2025_02.steps.size
    assert_equal Date.new(2025, 2, 1), period_2025_02.steps.first
    assert_equal Date.new(2025, 2, 28), period_2025_02.steps.last
  end
end
