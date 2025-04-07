module Accounts
  class Destroy < ApplicationOperation
    Success = Data.define(:account)
    Failure = Data.define(:account)

    def initialize(id:)
      @id = id
    end

    def call
      account = Account.find(@id)

      return Success[account:] if account.destroy

      Failure[account:]
    end
  end
end
