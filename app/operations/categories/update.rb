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

      if category.update(@attributes)
        Success[category:]
      else
        Failure[category:]
      end
    end
  end
end
