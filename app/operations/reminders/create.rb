module Reminders
  class Create < ApplicationOperation
    Success = Data.define(:reminder)
    Failure = Data.define(:reminder)

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      reminder = Reminder.new(@attributes)

      if reminder.save
        Success[reminder:]
      else
        Failure[reminder:]
      end
    end
  end
end
