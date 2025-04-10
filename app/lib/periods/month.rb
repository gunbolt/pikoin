module Periods
  class Month < Period
    def initialize(value)
      @value = value
    end

    def range
      @range ||= begin
        year, month = value.split("-").map(&:to_i)

        Date.new(year, month).all_month
      end
    end

    def steps
      @steps ||= range.to_a
    end
  end
end
