FactoryBot.define do
  factory :transfer do
    to_create do |transfer|
      transfer.save!
      Record.create!(transfer.attributes_for_expense_record)
      Record.create!(transfer.attributes_for_income_record)
    end

    from_account factory: :account
    to_account factory: :account

    amount_cents { 95_00 }
    occurred_on { 2.days.ago }
  end
end
