require "application_system_test_case"

module Insights
  class ListSystemTest < ApplicationSystemTestCase
    test "display cashflow insight" do
      create(:income, amount_cents: 10_00, occurred_on: Time.zone.today)
      create(:expense, amount_cents: 1_00, occurred_on: Time.zone.today)
      create(:expense, amount_cents: 2_00, occurred_on: 10.days.ago)
      create(:expense, amount_cents: 4_00, occurred_on: 1.year.ago)

      visit root_path(as: create(:user))

      assert_text t("Cashflow")
      assert_text Money.new(7_00).format(sign_positive: true)
      assert_text Money.new(10_00).format(sign_positive: true)
      assert_text Money.new(-3_00).format

      select t("period.7d"), from: "period"

      assert_text Money.new(9_00).format(sign_positive: true)
      assert_text Money.new(10_00).format(sign_positive: true)
      assert_text Money.new(-1_00).format

      select t("period.all"), from: "period"

      assert_text Money.new(3_00).format(sign_positive: true)
      assert_text Money.new(10_00).format(sign_positive: true)
      assert_text Money.new(-7_00).format
    end
  end
end
