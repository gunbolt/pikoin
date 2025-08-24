module Accounts
  class Update < ApplicationOperation
    prop :id, Id
    prop :attributes, Hash

    Success = Result.define(account: Account)
    Failure = Result.define(account: Account)

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
