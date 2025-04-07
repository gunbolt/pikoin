require "application_system_test_case"

module Templates
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      template = create(:template)

      visit_edit_template_page(template:)

      accept_confirm t("views.templates.edit.remove_confirm") do
        click_link I18n.t("views.templates.edit.remove")
      end

      assert_current_path templates_path
      assert_css ".alert-success", text: t("templates.destroy.success")
      refute_text template.title
    end

    private

    def visit_edit_template_page(template:)
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.templates")

      click_link template.title, href: edit_template_path(template)
    end
  end
end
