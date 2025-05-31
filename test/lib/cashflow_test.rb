require "test_helper"

class CashflowTest < ActiveSupport::TestCase
  test "#balance" do
    assert_equal Money.new(0),
      Cashflow[income: Money.new(0), expense: Money.new(0)].balance

    assert_equal Money.new(3_00),
      Cashflow[income: Money.new(4_00), expense: Money.new(-100)].balance

    assert_equal Money.new(-2_00),
      Cashflow[income: Money.new(2_00), expense: Money.new(-4_00)].balance
  end
end
