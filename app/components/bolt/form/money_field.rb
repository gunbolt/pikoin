module Bolt
  class MoneyField < Base
    def initialize(form, attribute, allow_negative: false, **)
      @form = form
      @attribute = attribute
      @allow_negative = allow_negative

      super(**)
    end

    private

    def view_template
      Bolt.TextField @form, @attribute,
        class: "input w-full",
        data: {
          controller: "money-field",
          money_field_allow_negative_value: @allow_negative.to_s
        },
        **@attributes
    end
  end
end
