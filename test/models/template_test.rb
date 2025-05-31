require "test_helper"

class TemplateTest < ActiveSupport::TestCase
  test "associations" do
    template = Template.new

    assert belong_to(:account).matches?(template)
    assert belong_to(:category).matches?(template)
  end

  test "validations" do
    template = create(:template)

    assert validate_presence_of(:title).matches?(template)
    assert validate_presence_of(:position).matches?(template)

    assert validate_uniqueness_of(:title)
      .case_insensitive
      .matches?(template)

    assert validate_numericality_of(:amount_cents)
      .is_greater_than_or_equal_to(0)
      .matches?(template)

    assert validate_length_of(:title).is_at_most(40).matches?(template)

    assert validate_length_of(:note)
      .is_at_most(32)
      .allow_nil
      .matches?(template)
  end

  test ".next_position" do
    assert_equal 1, Template.next_position

    create(:template, position: 1)
    assert_equal 2, Template.next_position

    create(:template, position: 829)
    assert_equal 830, Template.next_position
  end

  test "#amount" do
    expense = Template.new(
      group: :expense,
      amount_cents: 1234
    )
    income = Template.new(
      group: :income,
      amount_cents: 1234
    )
    no_amount = Template.new(group: :expense, amount_cents: 0)

    assert_equal Money.new(-12_34), expense.amount
    assert_equal Money.new(12_34), income.amount
    assert no_amount.amount.zero?
  end
end
