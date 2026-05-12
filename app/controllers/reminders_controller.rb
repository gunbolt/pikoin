class RemindersController < ApplicationController
  def index
    reminders = Reminder.all

    render Views::Reminders::Index.new(reminders:)
  end

  def show
    reminder = Reminder.find(params[:id])
    occurrences = reminder.occurrences.order(occurs_on: :desc)

    render Views::Reminders::Show.new(reminder:, occurrences:)
  end

  def new
    reminder = Reminder.new(config: build_config)

    render Views::Reminders::New.new(reminder:, accounts:, categories:)
  end

  def create
    case Reminders::Create.call(attributes: reminder_params)
    in Reminders::Create::Success
      redirect_to reminders_path, notice: t("Reminder created")
    in Reminders::Create::Failure(reminder)
      render Views::Reminders::New.new(reminder:, accounts:, categories:),
        status: :unprocessable_content
    end
  end

  private

  def build_config
    case params[:config]
    when "monthly"
      ReminderMonthlyConfig.new
    end
  end

  def reminder_params
    params.expect(reminder: [
      :title, :group, :account_id, :category_id, :amount_cents, :note,
      :config_type, config_attributes: %i[day]
    ]).to_h
  end

  def accounts = Account.active.order(:position)

  def categories = Category.order(:position)
end
