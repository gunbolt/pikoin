FactoryBot.define do
  factory :reminder do
    account
    category

    sequence(:title) { |n| "Reminder #{n}" }
    group { :expense }
    amount_cents { 10_00 }
    config { association :reminder_monthly_config }
  end
end
