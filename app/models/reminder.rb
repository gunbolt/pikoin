class Reminder < ApplicationRecord
  enum :group, {expense: -1, income: 1}, validate: true

  belongs_to :account
  belongs_to :category

  has_many :occurrences, class_name: "ReminderOccurrence", dependent: :destroy

  delegated_type :config, types: %w[ReminderMonthlyConfig], dependent: :destroy

  accepts_nested_attributes_for :config, update_only: true

  validates :title, presence: true
  validates :note, presence: true, allow_blank: true

  validates :title, uniqueness: {case_sensitive: false}

  validates :amount_cents, numericality: {greater_than_or_equal_to: 0}

  validates :title, length: {maximum: 40}
  validates :note, length: {maximum: 32}

  def amount
    Money.new(amount_cents * self.class.groups[group])
  end
end
