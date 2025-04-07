FactoryBot.define do
  factory :account do
    sequence(:title) { |n| "Account #{n}" }
    color { "#012345" }
    initial_amount_cents { 0 }
    sequence(:position)
  end
end
