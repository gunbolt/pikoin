module Bolt
  class RadioButton < Base
    def initialize(form, attribute, value, **)
      @form = form
      @attribute = attribute
      @value = value

      super(**)
    end

    private

    def view_template
      @form.radio_button @attribute, @value, class: "radio radio-primary", **@attributes
    end
  end
end
