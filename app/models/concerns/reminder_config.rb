module ReminderConfig
  extend ActiveSupport::Concern

  included do
    has_one :reminder, as: :config, touch: true
  end

  def next_occurrence_date
    raise NoMethodError, "You must implement #{self.class.name}#next_occurrence_date"
  end
end
