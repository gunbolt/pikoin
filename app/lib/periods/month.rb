module Periods
  class Month < Period
    def initialize(value)
      @value = value
    end

    def steps
      @steps ||= begin
        year, month = value.split("-").map(&:to_i)

        Date.new(year, month).all_month.to_a
      end
    end
  end
end
