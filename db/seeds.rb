# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  User.create!(
    email: Constants::DEV_USER_EMAIL,
    password: Constants::DEV_USER_PASSWORD
  )

  COLORS = %w[
    #122230 #244a63 #6882a8 #b1cbe2
    #d9eaf8 #e1e3d2 #afe4bd #48c39a
    #279098 #333a7f #995fbf #cc88e1
    #f9b9d8 #ed6697 #bb3c63 #692851
    #542730 #9f4444 #d9865d #f6d995
    #efba3f #c6c85f #84b25f #408450
  ]

  accounts = [
    {title: "Credit card", color: COLORS[0], initial_amount_cents: -500_00},
    {title: "Savings", color: COLORS[4], initial_amount_cents: 1000_00},
    {title: "Cash", color: COLORS[8], initial_amount_cents: 100_00}
  ].map do |attributes|
    Accounts::Create.call(attributes:).account
  end

  expense_categories = [
    {title: "Groceries", color: COLORS[3]},
    {title: "Utilities", color: COLORS[11]},
    {title: "Dining", color: COLORS[15]}
  ].map do |attributes|
    Categories::Create.call(attributes:).category
  end

  income_categories = [
    {title: "Wage", color: COLORS[7]}
  ].map do |attributes|
    Categories::Create.call(attributes:).category
  end

  [
    {
      title: "Grocery Shopping",
      group: :expense,
      category: expense_categories[0],
      amount_cents: 600_00,
      note: "Weekly groceries"
    },
    {
      title: "Monthly wage",
      group: :income,
      account: accounts[0],
      category: income_categories[0],
      amount_cents: 3000_00,
      note: "Wage"
    }
  ].each do |attributes|
    Templates::Create.call(attributes:)
  end

  12.times do |month|
    dates = month.month.ago.to_date.all_month.to_a.select { it <= Time.zone.today }

    Records::Create.call(
      attributes: {
        account: accounts.sample,
        category: income_categories.sample,
        group: :income,
        amount_cents: (1500_00..3000_00).to_a.sample,
        occurred_on: dates.sample,
        note: "Wage"
      }
    )

    15.times do
      Records::Create.call(
        attributes: {
          account: accounts.sample,
          category: expense_categories.sample,
          group: :expense,
          amount_cents: (5_00..100_00).to_a.sample,
          occurred_on: dates.sample
        }
      )
    end

    3.times do
      from_account = accounts.sample
      to_account = (accounts - [from_account]).sample

      Transfers::Create.call(
        attributes: {
          from_account: from_account,
          to_account: to_account,
          amount_cents: (50_00..150_00).to_a.sample,
          occurred_on: dates.sample
        }
      )
    end
  end
end
