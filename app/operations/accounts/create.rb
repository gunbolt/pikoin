module Accounts
  class Create < ApplicationOperation
    Success = Data.define(:account)
    Failure = Data.define(:account)

    def initialize(attributes:)
      @attributes = attributes
    end

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
