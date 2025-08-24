module Transfers
  class Create < ApplicationOperation
    prop :attributes, Hash

    Success = Result.define(transfer: Transfer)
    Failure = Result.define(transfer: Transfer)

    def call
      transfer = Transfer.new(@attributes)

      ActiveRecord::Base.transaction do
        transfer.save!
        Record.create!(transfer.attributes_for_expense_record)
        Record.create!(transfer.attributes_for_income_record)

        Success[transfer:]
      rescue
        Failure[transfer:]
      end
    end
  end
end
