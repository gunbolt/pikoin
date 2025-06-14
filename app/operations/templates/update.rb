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

      if template.update(@attributes)
        Success[template:]
      else
        Failure[template:]
      end
    end
  end
end
