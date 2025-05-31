module Bolt
  class Submit < Base
    def initialize(form, value = nil, **)
      @form = form
      @value = value

      super(**)
    end

    private

    def view_template(&)
      @form.submit @value, **@attributes, class: "btn btn-primary"
    end
  end
end
