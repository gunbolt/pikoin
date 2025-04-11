class Transfer < ApplicationRecord
  belongs_to :from_account, class_name: "Account"
  belongs_to :to_account, class_name: "Account"

  has_one :expense_record,
    -> { expense },
    class_name: "Record",
    dependent: :destroy
  has_one :income_record,
    -> { income },
    class_name: "Record",
    dependent: :destroy

  validates :occurred_on, presence: true
  validates :note, presence: true, allow_blank: true

  validates :amount_cents, numericality: {greater_than: 0}

  validates :note, length: {maximum: 32}

  validates :to_account_id, comparison: {
    other_than: :from_account_id,
    message: :must_be_different_from_origin_account
  }

  def attributes_for_expense_record
    attributes_for_records.merge(group: "expense", account_id: from_account_id)
  end

  def attributes_for_income_record
    attributes_for_records.merge(group: "income", account_id: to_account_id)
  end

  private

  def attributes_for_records
    {
      transfer_id: id,
      amount_cents: amount_cents,
      occurred_on: occurred_on,
      note: note,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
