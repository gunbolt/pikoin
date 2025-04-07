FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category #{n}" }
    color { "#012345" }
    sequence(:position)
  end
end
