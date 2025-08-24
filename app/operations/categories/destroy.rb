module Categories
  class Destroy < ApplicationOperation
    prop :id, Id

    Success = Result.define(category: Category)
    Failure = Result.define(category: Category)

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
