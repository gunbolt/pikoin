class ReminderMonthlyConfig < ApplicationRecord
  include ReminderConfig

  validates :day, inclusion: {in: 1..28}

  def description = I18n.t("Monthly on the %{day}", day:)

  def next_occurrence_date(base_date: Time.zone.today)
    same_month = base_date.change(day:)

    if same_month.after?(base_date)
      same_month
    else
      same_month + 1.month
    end
  end
end
