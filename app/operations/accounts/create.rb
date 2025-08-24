module Accounts
  class Create < ApplicationOperation
    prop :attributes, Hash

    Success = Result.define(account: Account)
    Failure = Result.define(account: Account)

    def call
      account = Account.new(default_attributes.merge(@attributes))

      if account.save
        Success[account:] if account.save
      else
        Failure[account:]
      end
    end

    private

    def default_attributes = {position: Account.next_position}
  end
end
