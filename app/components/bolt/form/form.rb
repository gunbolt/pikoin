module Bolt
  class Form < Phlex::HTML
    include Phlex::Rails::Helpers::FormWith

    def initialize(**options)
      @options = options
    end

    private

    def view_template(&)
      form_with(**@options) do |form|
        Bolt.FormBuilder form:, &
      end
    end
  end
end
