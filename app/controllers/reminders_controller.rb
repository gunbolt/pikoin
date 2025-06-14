class RemindersController < ApplicationController
  def index
    reminders = Reminder.all

    render Views::Reminders::Index.new(reminders:)
  end
end
