require "application_system_test_case"

module Templates
  class ReorderSystemTest < ApplicationSystemTestCase
    test "reorder" do
      template_a = create(:template, position: 1)
      template_b = create(:template, position: 2)
      template_c = create(:template, position: 3)

      visit_templates_page

      row_a = page.find("[data-id='#{template_a.id}']")
      row_b = page.find("[data-id='#{template_b.id}']")
      row_c = page.find("[data-id='#{template_c.id}']")

      row_c.find(".sortable-handle").drag_to(row_a.find(".sortable-handle"))
      row_a.find(".sortable-handle").drag_to(row_b.find(".sortable-handle"))

      row_1, row_2, row_3 = page.all("[data-id]")

      assert row_1.has_text?(template_c.title)
      assert row_2.has_text?(template_a.title)
      assert row_3.has_text?(template_b.title)
      assert_equal 0, template_c.reload.position
      assert_equal 1, template_a.reload.position
      assert_equal 2, template_b.reload.position
    end

    private

    def visit_templates_page
      visit root_path(as: create(:user))

      click_link t("Templates")
    end
  end
end
