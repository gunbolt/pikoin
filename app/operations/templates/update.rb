module Templates
  class Update < ApplicationOperation
    Success = Data.define(:template)
    Failure = Data.define(:template)

    def initialize(id:, attributes:)
      @id = id
      @attributes = attributes
    end

    def call
      template = Template.find(@id)

      return Success[template:] if template.update(@attributes)

      Failure[template:]
    end
  end
end
