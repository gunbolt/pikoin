module Bolt
  class FormBuilder < Phlex::HTML
    def initialize(form:)
      @form = form
    end

    def label(...) = Bolt.Label(@form, ...)

    def text_field(...) = Bolt.TextField(@form, ...)

    def hidden_field(...) = @form.hidden_field(...)

    def money_field(...) = Bolt.MoneyField(@form, ...)

    def email_field(...) = Bolt.EmailField(@form, ...)

    def password_field(...) = Bolt.PasswordField(@form, ...)

    def date_field(...) = Bolt.DateField(@form, ...)

    def select(...) = Bolt.Select(@form, ...)

    def collection_select(...) = Bolt.CollectionSelect(@form, ...)

    def color_picker(...) = Bolt.ColorPicker(@form, ...)

    def toggle(...) = Bolt.Toggle(@form, ...)

    def radio_button(...) = Bolt.RadioButton(@form, ...)

    def field_wrapper(...) = Bolt.FieldWrapper(...)

    def error_summary = Bolt.ErrorSummary(@form)

    def field_error(...) = Bolt.FieldError(@form, ...)

    def submit(...) = Bolt.Submit(@form, ...)

    def fields_for(*, **, &)
      @form.fields_for(*, **) do |form|
        Bolt.FormBuilder form:, &
      end
    end

    private

    def view_template(&) = yield
  end
end
