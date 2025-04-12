require "test_helper"

class LedgerEntryTest < ActiveSupport::TestCase
  test "#balance" do
    assert_equal Money.new(0),
      LedgerEntry[
        label: "X",
        running_total: Money.new(800),
        income: Money.new(0),
        expense: Money.new(0)
      ].balance

    assert_equal Money.new(300),
      LedgerEntry[
        label: "Y",
        running_total: Money.new(800),
        income: Money.new(400),
        expense: Money.new(-100)
      ].balance

    assert_equal Money.new(-200),
      LedgerEntry[
        label: "Z",
        running_total: Money.new(800),
        income: Money.new(200),
        expense: Money.new(-400)
      ].balance
  end
end
