module Records
  class Update < ApplicationOperation
    prop :id, Id
    prop :attributes, Hash

    Success = Result.define(record: Record)
    Failure = Result.define(record: Record)

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
