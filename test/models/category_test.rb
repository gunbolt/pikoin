require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "associations" do
    category = Category.new

    assert have_many(:records).dependent(:destroy).matches?(category)
    assert have_many(:reminders).dependent(:destroy).matches?(category)
    assert have_many(:templates).dependent(:destroy).matches?(category)
  end

  test "validations" do
    category = Category.new

    assert validate_presence_of(:title).matches?(category)
    assert validate_presence_of(:color).matches?(category)
    assert validate_presence_of(:position).matches?(category)

    assert validate_length_of(:title).is_at_most(40).matches?(category)

    assert allow_value("#FF00aa").for(:color).matches?(category)
    refute allow_value("FF00aa").for(:color).matches?(category)
    refute allow_value("#fff").for(:color).matches?(category)
    refute allow_value("#ff00aaff").for(:color).matches?(category)
    refute allow_value("#ff00zz").for(:color).matches?(category)
    refute allow_value("random").for(:color).matches?(category)
  end

  test ".next_position" do
    assert_equal 1, Category.next_position

    create(:category, position: 1)
    assert_equal 2, Category.next_position

    create(:category, position: 829)
    assert_equal 830, Category.next_position
  end
end
