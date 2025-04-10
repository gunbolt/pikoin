module Periods
  class Year < Period
    def initialize(value)
      @value = value
    end

    def range
      @range ||= Date.new(value.to_i).all_year
    end

    def steps
      @steps ||= range.step(1.month).map { it..it.end_of_month }
    end
  end
end
