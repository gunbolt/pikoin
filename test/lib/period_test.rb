require "test_helper"

class PeriodTest < ActiveSupport::TestCase
  test "#range" do
    period_2024 = Period.for("2024")
    period_2026 = Period.for("2026")
    period_2025_04 = Period.for("2025-04")
    period_2025_02 = Period.for("2025-02")

    assert_equal Date.new(2024, 1, 1)..Date.new(2024, 12, 31),
      period_2024.range
    assert_equal Date.new(2026, 1, 1)..Date.new(2026, 12, 31),
      period_2026.range
    assert_equal Date.new(2025, 4, 1)..Date.new(2025, 4, 30),
      period_2025_04.range
    assert_equal Date.new(2025, 2, 1)..Date.new(2025, 2, 28),
      period_2025_02.range
  end

  test "#steps" do
    period_2024 = Period.for("2024")
    period_2026 = Period.for("2026")
    period_2025_04 = Period.for("2025-04")
    period_2025_02 = Period.for("2025-02")

    assert_equal 12, period_2024.steps.size
    assert_equal Date.new(2024, 3, 1)..Date.new(2024, 3, 31),
      period_2024.steps[2]

    assert_equal 12, period_2026.steps.size
    assert_equal Date.new(2026, 5, 1)..Date.new(2026, 5, 31),
      period_2026.steps[4]

    assert_equal 30, period_2025_04.steps.size
    assert_equal Date.new(2025, 4, 10), period_2025_04.steps[9]

    assert_equal 28, period_2025_02.steps.size
    assert_equal Date.new(2025, 2, 19), period_2025_02.steps[18]
  end
end
