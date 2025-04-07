module Records
  class Destroy < ApplicationOperation
    Success = Data.define(:record)
    Failure = Data.define(:record)

    def initialize(id:)
      @id = id
    end

    def call
      record = Record.find(@id)

      return Success[record:] if record.destroy

      Failure[record:]
    end
  end
end
