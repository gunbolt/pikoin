module Bolt
  class Base < Phlex::HTML
    include PhlexIcons

    include Phlex::Rails::Helpers::T
    include Phlex::Rails::Helpers::LinkTo

    def initialize(**attributes)
      @extra_classes = attributes.delete(:class)
      @attributes = attributes
    end

    private

    if Rails.env.development?
      def before_template
        comment { "Before #{self.class.name}" }
        super
      end
    end
  end
end
