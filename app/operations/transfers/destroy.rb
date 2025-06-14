module Transfers
  class Destroy < ApplicationOperation
    Success = Data.define(:transfer)
    Failure = Data.define(:transfer)

    def initialize(id:)
      @id = id
    end

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
