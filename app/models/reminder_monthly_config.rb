class ReminderMonthlyConfig < ApplicationRecord
  include ReminderConfig

  validates :day, inclusion: {in: 1..28}

  def description = I18n.t("Monthly on the %{day}", day:)

  def next_occurrence_date
    today = Time.zone.today
    this_month = today.change(day:)

    if this_month.after?(today)
      this_month
    else
      this_month + 1.month
    end
  end
end
