module ReminderConfig
  extend ActiveSupport::Concern

  included do
    has_one :reminder, as: :config, touch: true
  end
end
