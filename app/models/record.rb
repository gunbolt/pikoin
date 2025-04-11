class Record < ApplicationRecord
  enum :group, {expense: -1, income: 1}, validate: true

  belongs_to :account
  belongs_to :category, optional: true
  belongs_to :transfer, optional: true

  scope :without_transfers, -> { where(transfer_id: nil) }

  validates :category, presence: true, unless: :transfer_id?
  validates :category, absence: true, if: :transfer_id?
  validates :occurred_on, presence: true
  validates :note, presence: true, allow_blank: true

  validates :amount_cents, numericality: {greater_than: 0}

  validates :note, length: {maximum: 32}

  def self.total_amount = Money.new(sum('amount_cents * "group"'))

  def amount
    Money.new(amount_cents * self.class.groups[group])
  end
end
