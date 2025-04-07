module Bolt
  class TextField < Base
    def initialize(form, attribute, **)
      @form = form
      @attribute = attribute
      @object = @form.object.presence

      super(**)
    end

    private

    def view_template
      @form.text_field(
        @attribute,
        class: [
          "input w-full",
          ("input-error" if @object&.errors&.key?(@attribute))
        ],
        **@attributes
      )
    end
  end
end
