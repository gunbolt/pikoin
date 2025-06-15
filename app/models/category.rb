class Category < ApplicationRecord
  include Sortable

  has_many :records, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :templates, dependent: :destroy

  validates :title, presence: true
  validates :color, presence: true
  validates :position, presence: true

  validates :title, length: {maximum: 40}

  validates :color, format: {with: Constants::COLOR_REGEX, allow_blank: true}
end
