module Records
  class Create < ApplicationOperation
    Success = Data.define(:record)
    Failure = Data.define(:record)

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      record = Record.new(@attributes)

      if record.save
        Success[record:]
      else
        Failure[record:]
      end
    end
  end
end
