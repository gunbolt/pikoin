module Templates
  class Destroy < ApplicationOperation
    Success = Data.define(:template)
    Failure = Data.define(:template)

    def initialize(id:)
      @id = id
    end

    def call
      template = Template.find(@id)

      if template.destroy
        Success[template:]
      else
        Failure[template:]
      end
    end
  end
end
