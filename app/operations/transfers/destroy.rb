module Transfers
  class Destroy < ApplicationOperation
    prop :id, Id

    Success = Result.define(transfer: Transfer)
    Failure = Result.define(transfer: Transfer)

    def call
      transfer = Transfer.find(@id)

      if transfer.destroy!
        Success[transfer:]
      else
        Failure[transfer:]
      end
    end
  end
end
