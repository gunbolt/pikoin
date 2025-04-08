require "test_helper"

class CashflowTest < ActiveSupport::TestCase
  test "#balance" do
    assert_equal Money.new(0),
      Cashflow[income: Money.new(0), expense: Money.new(0)].balance

    assert_equal Money.new(300),
      Cashflow[income: Money.new(400), expense: Money.new(-100)].balance

    assert_equal Money.new(-200),
      Cashflow[income: Money.new(200), expense: Money.new(-400)].balance
  end
end
