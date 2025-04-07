module Categories
  class Update < ApplicationOperation
    Success = Data.define(:category)
    Failure = Data.define(:category)

    def initialize(id:, attributes:)
      @id = id
      @attributes = attributes
    end

    def call
      category = Category.find(@id)

      return Success[category:] if category.update(@attributes)

      Failure[category:]
    end
  end
end
