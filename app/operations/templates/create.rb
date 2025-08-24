module Templates
  class Create < ApplicationOperation
    prop :attributes, Hash

    Success = Result.define(template: Template)
    Failure = Result.define(template: Template)

    def call
      template = Template.new(default_attributes.merge(@attributes))

      if template.save
        Success[template:]
      else
        Failure[template:]
      end
    end

    def default_attributes = {position: Template.next_position}
  end
end
