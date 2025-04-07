module Templates
  class Create < ApplicationOperation
    Success = Data.define(:template)
    Failure = Data.define(:template)

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      template = Template.new(default_attributes.merge(@attributes))

      return Success[template:] if template.save

      Failure[template:]
    end

    def default_attributes = {position: Template.next_position}
  end
end
