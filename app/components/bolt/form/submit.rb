module Bolt
  class Submit < Base
    def initialize(form, **)
      @form = form

      super(**)
    end

    private

    def view_template(&)
      @form.submit class: "btn btn-primary"
    end
  end
end
