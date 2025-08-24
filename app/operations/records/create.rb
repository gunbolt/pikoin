module Records
  class Create < ApplicationOperation
    prop :attributes, Hash

    Success = Result.define(record: Record)
    Failure = Result.define(record: Record)

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
