module Records
  class Destroy < ApplicationOperation
    prop :id, Id

    Success = Result.define(record: Record)
    Failure = Result.define(record: Record)

    def call
      record = Record.find(@id)

      if record.destroy
        Success[record:]
      else
        Failure[record:]
      end
    end
  end
end
