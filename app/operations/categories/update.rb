module Categories
  class Update < ApplicationOperation
    prop :id, Id
    prop :attributes, Hash

    Success = Result.define(category: Category)
    Failure = Result.define(category: Category)

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
