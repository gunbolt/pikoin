module TranslationHelpers
  def t(...) = I18n.t(...)

  def field(model, attribute) = model.human_attribute_name(attribute)

  def submit_text(model, action = :create)
    model_name = t("activerecord.models.#{model.model_name.i18n_key}")

    t("helpers.submit.#{action}", model: model_name)
  end
end
