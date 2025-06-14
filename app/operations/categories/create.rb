module Categories
  class Create < ApplicationOperation
    Success = Data.define(:category)
    Failure = Data.define(:category)

    def initialize(attributes:)
      @attributes = attributes
    end

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
