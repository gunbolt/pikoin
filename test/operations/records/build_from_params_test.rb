require "test_helper"

module Records
  class BuildFromParamsTest < ActiveSupport::TestCase
    test "building expense" do
      account = create(:account)
      result = Records::BuildFromParams.call(
        account: account, params: {group: "expense"}
      )
      expected_attributes = Record.new(
        account: account,
        group: :expense,
        occurred_on: Time.zone.today
      ).attributes

      assert_equal expected_attributes, result.record.attributes
    end

    test "building income" do
      account = create(:account)
      result = Records::BuildFromParams.call(
        account: account, params: {group: "income"}
      )
      expected_attributes = Record.new(
        account: account,
        group: :income,
        occurred_on: Time.zone.today
      ).attributes

      assert_equal expected_attributes, result.record.attributes
    end

    test "default building" do
      account = create(:account)
      result = Records::BuildFromParams.call(account: account, params: {})
      expected_attributes = Record.new(
        account: account, occurred_on: Time.zone.today
      ).attributes

      assert_equal expected_attributes, result.record.attributes
    end

    test "building from template" do
      account = create(:account)
      template = create(:template, amount_cents: 5424, note: "My template")

      result = Records::BuildFromParams.call(
        account: account, params: {template: template.id.to_s}
      )

      assert_equal template.account, result.record.account
      assert_equal template.category, result.record.category
      assert_equal template.amount_cents, result.record.amount_cents
      assert_equal template.note, result.record.note
      assert_equal Time.zone.today, result.record.occurred_on
    end

    test "building from template with empty note" do
      account = create(:account)
      template = create(:template, title: "My title", note: "")

      result = Records::BuildFromParams.call(
        account: account, params: {template: template.id.to_s}
      )

      assert_equal template.title, result.record.note
    end

    test "building from missing template" do
      account = create(:account)
      assert_raises ActiveRecord::RecordNotFound do
        Records::BuildFromParams.call(
          account: account, params: {template: "not-found"}
        )
      end
    end
  end
end
