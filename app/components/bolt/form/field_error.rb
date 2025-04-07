module Bolt
  class FieldError < Base
    def initialize(form, attribute, **)
      @form = form
      @attribute = attribute

      super(**)
    end

    private

    def render? = @form.object.errors.key?(@attribute)

    def view_template(&)
      span class: "text-sm text-error", data: {turbo_temporary: true} do
        @form.object.errors[@attribute].to_sentence.upcase_first
      end
    end
  end
end
