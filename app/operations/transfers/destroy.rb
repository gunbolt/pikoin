module Transfers
  class Destroy < ApplicationOperation
    Success = Data.define(:transfer)
    Failure = Data.define(:transfer)

    def initialize(id:)
      @id = id
    end

    def call
      transfer = Transfer.find(@id)

      return Success[transfer:] if transfer.destroy!

      Failure[transfer:]
    end
  end
end
