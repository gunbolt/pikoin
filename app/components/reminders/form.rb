module Components
  module Reminders
    class Form < Base
      def initialize(reminder:, accounts:, categories:)
        @reminder = reminder
        @accounts = accounts
        @categories = categories
      end

      private

      def view_template
        form_with model: @reminder do |form|
          Bolt.Stack do
            Bolt.ErrorSummary form

            Bolt.Panel do
              Bolt.Stack do
                Bolt.FieldWrapper do
                  Bolt.Label form, :title
                  Bolt.TextField form, :title
                  Bolt.FieldError form, :title
                end

                Bolt.FieldWrapper do
                  Bolt.Label form, :group, for: nil

                  div class: "flex flex-row gap-4" do
                    Bolt.FieldWrapper orientation: :horizontal do
                      Bolt.RadioButton form, :group, :expense
                      Bolt.Label form, :group, t("Expense"), value: :expense
                    end

                    Bolt.FieldWrapper orientation: :horizontal do
                      Bolt.RadioButton form, :group, :income
                      Bolt.Label form, :group, t("Income"), value: :income
                    end
                  end

                  Bolt.FieldError form, :group
                end

                div class: "flex flex-row gap-4" do
                  Bolt.FieldWrapper do
                    Bolt.Label form, :account_id
                    Bolt.CollectionSelect form, :account_id, @accounts,
                      :id, :title
                    Bolt.FieldError form, :account_id
                  end

                  Bolt.FieldWrapper do
                    Bolt.Label form, :category_id
                    Bolt.CollectionSelect form, :category_id, @categories,
                      :id, :title
                    Bolt.FieldError form, :category_id
                  end
                end

                Bolt.FieldWrapper do
                  Bolt.Label form, :amount_cents
                  Bolt.MoneyField form, :amount_cents
                  Bolt.FieldError form, :amount_cents
                end

                Bolt.FieldWrapper do
                  Bolt.Label form, :note
                  Bolt.TextField form, :note
                  Bolt.FieldError form, :note
                end

                form.hidden_field :config_type

                form.fields_for :config do |config_form|
                  Bolt.FieldWrapper do
                    Bolt.Label config_form, :day
                    Bolt.Select config_form, :day, 1..28
                    Bolt.FieldError config_form, :day
                  end
                end
              end
            end

            Bolt.Stack gap: :sm do
              Bolt.Submit form

              Bolt.LinkButton href: reminder_types_path, ghost: true do
                Lucide.ArrowLeft(class: "size-5")
                plain t("Cancel")
              end
            end
          end
        end
      end
    end
  end
end
