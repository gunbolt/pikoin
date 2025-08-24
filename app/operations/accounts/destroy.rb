module Accounts
  class Destroy < ApplicationOperation
    prop :id, Id

    Success = Result.define(account: Account)
    Failure = Result.define(account: Account)

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
