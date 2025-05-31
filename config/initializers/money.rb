Money.locale_backend = :currency
Money.rounding_mode = BigDecimal::ROUND_HALF_UP
Money.default_currency = Rails.configuration.default_currency
Money.default_formatting_rules = {sign_before_symbol: true}
