module Bolt
  class DateField < Base
    def initialize(form, attribute, **)
      @form = form
      @attribute = attribute

      super(**)
    end

    private

    def view_template(&)
      @form.date_field @attribute, class: "input w-full", **@attributes, &
    end
  end
end
