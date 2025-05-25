Period = Data.define(:range) do
  self::ALL = {
    "tm" => -> { Time.zone.today.all_month },
    "lm" => -> { 1.month.ago.to_date.all_month },
    "ty" => -> { Time.zone.today.all_year },
    "ly" => -> { 1.year.ago.to_date.all_year },
    "7d" => -> { 7.days.ago.to_date..Time.zone.today },
    "1m" => -> { 1.month.ago.to_date..Time.zone.today },
    "3m" => -> { 3.months.ago.to_date..Time.zone.today },
    "6m" => -> { 6.months.ago.to_date..Time.zone.today },
    "1y" => -> { 1.year.ago.to_date..Time.zone.today },
    "2y" => -> { 2.year.ago.to_date..Time.zone.today },
    "all" => -> {}
  }

  def self.for(value)
    self[range: self::ALL[value].call]
  end
end
