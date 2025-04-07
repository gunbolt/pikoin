FactoryBot.define do
  factory :template do
    account
    category

    sequence(:title) { |n| "Template #{n}" }
    group { :expense }
    sequence(:position)
  end
end
