FactoryBot.define do
  factory :record do
    account
    category

    group { :expense }
    amount_cents { 1000 }
    occurred_on { 2.days.ago }
  end
end
