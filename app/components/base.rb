module Components
  class Base < Phlex::HTML
    include Components
    include PhlexIcons

    # Include any helpers you want to be available across all components
    include Phlex::Rails::Helpers::Flash
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::ImagePath
    include Phlex::Rails::Helpers::L
    include Phlex::Rails::Helpers::Request
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::T

    if Rails.env.development?
      def before_template
        comment { "Before #{self.class.name}" }
        super
      end
    end
  end
end
