module Transfers
  class Update < ApplicationOperation
    prop :id, Id
    prop :attributes, Hash

    Success = Result.define(transfer: Transfer)
    Failure = Result.define(transfer: Transfer)

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
