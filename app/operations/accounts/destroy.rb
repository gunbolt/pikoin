module Accounts
  class Destroy < ApplicationOperation
    Success = Data.define(:account)
    Failure = Data.define(:account)

    def initialize(id:)
      @id = id
    end

    def call
      account = Account.find(@id)

      if account.destroy
        Success[account:]
      else
        Failure[account:]
      end
    end
  end
end
