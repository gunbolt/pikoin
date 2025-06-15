require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "associations" do
    account = Account.new

    assert have_many(:records).dependent(:destroy).matches?(account)
    assert have_many(:reminders).dependent(:destroy).matches?(account)
    assert have_many(:templates).dependent(:destroy).matches?(account)
  end

  test "active scope" do
    account = create(:account)
    _archived_account = create(:account, archived: true)

    assert_equal [account], Account.active.to_a
  end

  test "validations" do
    account = Account.new

    assert validate_presence_of(:title).matches?(account)
    assert validate_presence_of(:color).matches?(account)
    assert validate_presence_of(:position).matches?(account)

    assert validate_length_of(:title).is_at_most(40).matches?(account)

    assert allow_value("#FF00aa").for(:color).matches?(account)
    refute allow_value("FF00aa").for(:color).matches?(account)
    refute allow_value("#fff").for(:color).matches?(account)
    refute allow_value("#ff00aaff").for(:color).matches?(account)
    refute allow_value("#ff00zz").for(:color).matches?(account)
    refute allow_value("random").for(:color).matches?(account)
  end

  test ".next_position" do
    assert_equal 1, Account.next_position

    create(:account, position: 1)
    assert_equal 2, Account.next_position

    create(:account, position: 829)
    assert_equal 830, Account.next_position
  end

  test "#balance" do
    account = create(:account)

    assert_equal Money.new(0), account.balance

    create(
      :record, :income,
      account: account,
      occurred_on: 10.days.ago,
      amount_cents: 12_00
    )

    assert_equal Money.new(12_00), account.balance

    create(
      :record, :expense,
      account: account,
      occurred_on: 5.days.ago,
      amount_cents: 8_00
    )

    assert_equal Money.new(4_00), account.balance

    create(
      :record, :expense,
      account: account,
      occurred_on: 1.day.ago,
      amount_cents: 15_00
    )

    assert_equal Money.new(-11_00), account.balance

    account.update!(initial_amount_cents: 30_00)

    assert_equal Money.new(19_00), account.balance

    assert_equal Money.new(30_00), account.balance(on: 1.year.ago)
    assert_equal Money.new(42_00), account.balance(on: 10.days.ago)
    assert_equal Money.new(34_00), account.balance(on: 5.days.ago)
    assert_equal Money.new(19_00), account.balance(on: 1.day.ago)
  end
end
