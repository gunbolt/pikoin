class Period < Literal::Enum(String)
  prop :range_proc, _Callable
  prop :label, String

  def label_i18n = I18n.t(@label, scope: :periods)

  def range = range_proc.call

  ThisMonth = new(
    "tm",
    range_proc: -> { Time.zone.today.all_month },
    label: "This month"
  )

  LastMonth = new(
    "lm",
    range_proc: -> { 1.month.ago.to_date.all_month },
    label: "Last month"
  )

  ThisYear = new(
    "ty",
    range_proc: -> { Time.zone.today.all_year },
    label: "This year"
  )

  LastYear = new(
    "ly",
    range_proc: -> { 1.year.ago.to_date.all_year },
    label: "Last year"
  )

  Last7Days = new(
    "7d",
    range_proc: -> { 7.days.ago.to_date..Time.zone.today },
    label: "Last 7 days"
  )

  Last30days = new(
    "30d",
    range_proc: -> { 30.days.ago..Time.zone.today },
    label: "Last 30 days"
  )

  Last3months = new(
    "3m",
    range_proc: -> { 3.months.ago.to_date..Time.zone.today },
    label: "Last 3 months"
  )

  Last6months = new(
    "6m",
    range_proc: -> { 6.months.ago.to_date..Time.zone.today },
    label: "Last 6 months"
  )

  Last12months = new(
    "12m",
    range_proc: -> { 12.months.ago.to_date..Time.zone.today },
    label: "Last 12 months"
  )

  Last24months = new(
    "24m",
    range_proc: -> { 24.months.ago.to_date..Time.zone.today },
    label: "Last 24 months"
  )

  All = new(
    "all",
    range_proc: -> {},
    label: "All"
  )
end
