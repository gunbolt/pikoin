module Templates
  class Destroy < ApplicationOperation
    Success = Data.define(:template)
    Failure = Data.define(:template)

    def initialize(id:)
      @id = id
    end

    def call
      template = Template.find(@id)

      return Success[template:] if template.destroy

      Failure[template:]
    end
  end
end
