require "application_system_test_case"

module Insights
  class ListSystemTest < ApplicationSystemTestCase
    test "display insights" do
      visit root_path(as: create(:user))

      assert_text t("components.insights.cashflow_card.title")
    end
  end
end
