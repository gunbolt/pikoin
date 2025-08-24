module Templates
  class Destroy < ApplicationOperation
    prop :id, Id

    Success = Result.define(template: Template)
    Failure = Result.define(template: Template)

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
