module Transfers
  class Create < ApplicationOperation
    Success = Data.define(:transfer)
    Failure = Data.define(:transfer)

    def initialize(attributes:)
      @attributes = attributes
    end

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
