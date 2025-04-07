class Template < ApplicationRecord
  include Sortable

  enum :group, {expense: -1, income: 1}, validate: true

  belongs_to :account
  belongs_to :category

  validates :title, presence: true
  validates :position, presence: true

  validates :title, uniqueness: {case_sensitive: false}

  validates :amount_cents, numericality: {greater_than_or_equal_to: 0}

  validates :title, length: {maximum: 40}
  validates :note, length: {maximum: 32}

  def amount
    Money.new(amount_cents * self.class.groups[group])
  end
end
