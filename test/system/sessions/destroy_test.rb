require "application_system_test_case"

module Sessions
  class DestroySystemTest < ApplicationSystemTestCase
    test "sign out" do
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.sign_out")

      assert_current_path sign_in_path
    end
  end
end
