require "application_system_test_case"

module Sessions
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid credentials" do
      create(:user, email: "example@example.com", password: "test123")

      visit root_path

      assert_css "h1", text: "pikoin"

      fill_in t("Email address"), with: "example@example.com"
      fill_in t("Password"), with: "test123"

      click_button t("Sign in")

      assert_current_path root_path
      assert_link t("Sign out")
    end

    test "invalid credentials" do
      visit root_path

      fill_in t("Email address"), with: "example@example.com"
      fill_in t("Password"), with: "test123"

      click_button t("Sign in")

      assert_current_path sign_in_path
      assert_content t("flashes.failure_after_create")
    end

    test "sign in rate limit" do
      create(:user, email: "example@example.com", password: "test123")

      visit root_path

      fill_in t("Email address"), with: "example@example.com"
      fill_in t("Password"), with: "WRONG"

      4.times do
        click_button t("Sign in")

        assert_content t("flashes.failure_after_create")
      end

      fill_in t("Email address"), with: "example@example.com"
      fill_in t("Password"), with: "test123"

      assert_current_path sign_in_path
    end
  end
end
