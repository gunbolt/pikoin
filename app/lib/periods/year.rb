module Periods
  class Year < Period
    def initialize(value)
      @value = value
    end

    def steps
      @steps ||= Date.new(value.to_i)
        .all_year
        .step(1.month)
        .map do
          it..it.end_of_month
        end
    end
  end
end
