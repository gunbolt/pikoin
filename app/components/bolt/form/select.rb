module Bolt
  class Select < Base
    def initialize(
      form,
      attribute,
      choices = nil,
      options = {},
      **
    )
      @form = form
      @attribute = attribute
      @choices = choices
      @options = options

      super(**)
    end

    private

    def view_template
      @form.select(
        @attribute,
        @choices,
        @options,
        class: "select w-full",
        **@attributes
      )
    end
  end
end
