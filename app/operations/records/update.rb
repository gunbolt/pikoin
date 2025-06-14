module Records
  class Update < ApplicationOperation
    Success = Data.define(:record)
    Failure = Data.define(:record)

    def initialize(id:, attributes:)
      @id = id
      @attributes = attributes
    end

    def call
      record = Record.find(@id)

      if record.update(@attributes)
        Success[record:]
      else
        Failure[record:]
      end
    end
  end
end
