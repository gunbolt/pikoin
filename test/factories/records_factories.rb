FactoryBot.define do
  factory :record do
    account
    category

    group { :expense }
    amount_cents { 1000 }
    occurred_on { 2.days.ago }

    factory :expense do
      group { :expense }
    end

    factory :income do
      group { :income }
    end
  end
end
