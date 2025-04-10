class Period
  attr_reader :value

  def self.for(value)
    case value
    in /^\d{4}$/ # YYYY
      Periods::Year.new(value)
    in /^\d{4}-(0[1-9]|1[0-2])$/ # YYYY-MM
      Periods::Month.new(value)
    end
  end

  def steps = raise NoMethodError, "You must implement #{self.class.name}#steps"
end
