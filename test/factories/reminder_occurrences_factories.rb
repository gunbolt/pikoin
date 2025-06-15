FactoryBot.define do
  factory :reminder_occurrence do
    reminder
    record

    occurs_on { "2025-06-15" }
  end
end
