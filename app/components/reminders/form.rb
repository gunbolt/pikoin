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
        Bolt.Form model: @reminder do |form|
          Bolt.Stack do
            form.error_summary

            Bolt.Panel do
              Bolt.Stack do
                form.field_wrapper do
                  form.label :title
                  form.text_field :title
                  form.field_error :title
                end

                form.field_wrapper do
                  form.label :group, for: nil

                  div class: "flex flex-row gap-4" do
                    form.field_wrapper orientation: :horizontal do
                      form.radio_button :group, :expense
                      form.label :group, t("Expense"), value: :expense
                    end

                    form.field_wrapper orientation: :horizontal do
                      form.radio_button :group, :income
                      form.label :group, t("Income"), value: :income
                    end
                  end

                  form.field_error :group
                end

                div class: "flex flex-row gap-4" do
                  form.field_wrapper do
                    form.label :account_id
                    form.collection_select :account_id, @accounts,
                      :id, :title
                    form.field_error :account_id
                  end

                  form.field_wrapper do
                    form.label :category_id
                    form.collection_select :category_id, @categories,
                      :id, :title
                    form.field_error :category_id
                  end
                end

                form.field_wrapper do
                  form.label :amount_cents
                  form.money_field :amount_cents
                  form.field_error :amount_cents
                end

                form.field_wrapper do
                  form.label :note
                  form.text_field :note
                  form.field_error :note
                end

                form.hidden_field :config_type

                form.fields_for :config do |config_form|
                  form.field_wrapper do
                    config_form.label :day
                    config_form.select :day, 1..28
                    config_form.field_error :day
                  end
                end
              end
            end

            Bolt.Stack gap: :sm do
              form.submit

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
