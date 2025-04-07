require "application_system_test_case"

module Sessions
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid credentials" do
      create(:user, email: "example@example.com", password: "test123")

      visit root_path

      assert_css "h1", text: t("views.sessions.new.page_title")

      fill_in t("helpers.label.session.email"), with: "example@example.com"
      fill_in t("helpers.label.session.password"), with: "test123"

      click_button t("helpers.submit.session.submit")

      assert_current_path root_path
      assert_link t("components.layouts.menu_items.sign_out")
    end

    test "invalid credentials" do
      visit root_path

      fill_in t("helpers.label.session.email"), with: "example@example.com"
      fill_in t("helpers.label.session.password"), with: "test123"

      click_button t("helpers.submit.session.submit")

      assert_current_path sign_in_path
      assert_content t("flashes.failure_after_create")
    end

    test "sign in rate limit" do
      create(:user, email: "example@example.com", password: "test123")

      visit root_path

      fill_in t("helpers.label.session.email"), with: "example@example.com"
      fill_in t("helpers.label.session.password"), with: "WRONG"

      4.times do
        click_button t("helpers.submit.session.submit")

        assert_content t("flashes.failure_after_create")
      end

      fill_in t("helpers.label.session.email"), with: "example@example.com"
      fill_in t("helpers.label.session.password"), with: "test123"

      assert_current_path sign_in_path
    end
  end
end
