module Transfers
  class Update < ApplicationOperation
    Success = Data.define(:transfer)
    Failure = Data.define(:transfer)

    def initialize(id:, attributes:)
      @id = id
      @attributes = attributes
    end

    def call
      transfer = Transfer.find(@id)

      ActiveRecord::Base.transaction do
        transfer.update!(@attributes)
        transfer.expense_record.update!(transfer.attributes_for_expense_record)
        transfer.income_record.update!(transfer.attributes_for_income_record)

        Success[transfer:]
      rescue
        Failure[transfer:]
      end
    end
  end
end
