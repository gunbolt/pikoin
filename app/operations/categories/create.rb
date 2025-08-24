module Categories
  class Create < ApplicationOperation
    prop :attributes, Hash

    Success = Result.define(category: Category)
    Failure = Result.define(category: Category)

    def call
      category = Category.new(default_attributes.merge(@attributes))

      if category.save
        Success[category:]
      else
        Failure[category:]
      end
    end

    def default_attributes = {position: Category.next_position}
  end
end
