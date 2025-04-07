module Accounts
  class Create < ApplicationOperation
    Success = Data.define(:account)
    Failure = Data.define(:account)

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      account = Account.new(default_attributes.merge(@attributes))

      return Success[account:] if account.save

      Failure[account:]
    end

    private

    def default_attributes = {position: Account.next_position}
  end
end
