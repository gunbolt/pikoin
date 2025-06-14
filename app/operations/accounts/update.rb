module Accounts
  class Update < ApplicationOperation
    Success = Data.define(:account)
    Failure = Data.define(:account)

    def initialize(id:, attributes:)
      @id = id
      @attributes = attributes
    end

    def call
      account = Account.find(@id)

      if account.update(@attributes)
        Success[account:]
      else
        Failure[account:]
      end
    end
  end
end
