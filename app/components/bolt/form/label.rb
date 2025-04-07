module Bolt
  class Label < Base
    def initialize(form, attribute, text = nil, **)
      @form = form
      @attribute = attribute
      @text = text
      @object = @form.object.presence

      super(**)
    end

    private

    def view_template(&)
      @form.label @attribute, @text,
        class: [
          "font-bold",
          ("text-error" if @object&.errors&.key?(@attribute))
        ],
        **@attributes,
        &
    end
  end
end
