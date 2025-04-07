module Records
  class Create < ApplicationOperation
    Success = Data.define(:record)
    Failure = Data.define(:record)

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      record = Record.new(@attributes)

      return Success[record:] if record.save

      Failure[record:]
    end
  end
end
