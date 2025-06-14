module Categories
  class Destroy < ApplicationOperation
    Success = Data.define(:category)
    Failure = Data.define(:category)

    def initialize(id:)
      @id = id
    end

    def call
      category = Category.find(@id)

      if category.destroy
        Success[category:]
      else
        Failure[category:]
      end
    end
  end
end
