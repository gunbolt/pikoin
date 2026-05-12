class ReminderOccurrencesController < ApplicationController
  def destroy
    case ReminderOccurrences::Dismiss.call(id: params[:id])
    in ReminderOccurrences::Dismiss::Success(occurrence)
      redirect_to reminder_path(occurrence.reminder), notice: t("Reminder dismissed")
    in ReminderOccurrences::Dismiss::Failure(occurrence)
      redirect_to reminder_path(occurrence.reminder), alert: t("There was a problem dismissing the reminder")
    end
  end
end
