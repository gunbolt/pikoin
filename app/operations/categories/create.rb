module Categories
  class Create < ApplicationOperation
    Success = Data.define(:category)
    Failure = Data.define(:category)

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      category = Category.new(default_attributes.merge(@attributes))

      return Success[category:] if category.save

      Failure[category:]
    end

    def default_attributes = {position: Category.next_position}
  end
end
