module Templates
  class Update < ApplicationOperation
    prop :id, Id
    prop :attributes, Hash

    Success = Result.define(template: Template)
    Failure = Result.define(template: Template)

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
