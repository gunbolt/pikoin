module Bolt
  class Toggle < Base
    def initialize(form, attribute, **)
      @form = form
      @attribute = attribute

      super(**)
    end

    private

    def view_template
      @form.checkbox @attribute, class: "toggle toggle-primary", **@attributes
    end
  end
end
