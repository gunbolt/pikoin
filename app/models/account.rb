class Account < ApplicationRecord
  include Sortable

  has_many :records, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :templates, dependent: :destroy

  # This is necessary to allow destroying associated transfers
  has_many :transfers, ->(account) {
    unscope(:where)
      .where(from_account_id: account.id)
      .or(where(to_account_id: account.id))
  }, dependent: :destroy

  scope :active, -> { where(archived: false) }

  validates :title, presence: true
  validates :color, presence: true
  validates :position, presence: true

  validates :title, length: {maximum: 40}

  validates :color, format: {with: Constants::COLOR_REGEX, allow_blank: true}

  def balance(on: Time.zone.today)
    records.on(..on).total + initial_amount
  end

  private

  def initial_amount = Money.new(initial_amount_cents)
end
