module Templates
  class Create < ApplicationOperation
    Success = Data.define(:template)
    Failure = Data.define(:template)

    def initialize(attributes:)
      @attributes = attributes
    end

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
