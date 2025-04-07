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

      return Success[account:] if account.update(@attributes)

      Failure[account:]
    end
  end
end
