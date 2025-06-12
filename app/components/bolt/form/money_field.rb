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
          **money_field_settings
        },
        **@attributes
    end

    def money_field_settings
      default_currency = Money.default_currency
      {
        money_field_allow_negative_value: @allow_negative.to_s,
        money_field_decimal_separator_value: default_currency.decimal_mark,
        money_field_thousands_separator_value: default_currency.thousands_separator,
        money_field_fraction_digits_value: default_currency.exponent
      }
    end
  end
end
