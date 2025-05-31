module Components
  module Records
    class Form < Base
      def initialize(record:, accounts:, categories:, cancel_href:)
        @record = record
        @accounts = accounts
        @categories = categories
        @cancel_href = cancel_href
      end

      private

      def view_template
        form_with model: @record, url: form_url do |form|
          Bolt.Stack do
            Bolt.ErrorSummary form

            Bolt.Panel do
              Bolt.Stack do
                Bolt.FieldWrapper do
                  Bolt.Label form, :group, for: nil

                  div class: "flex flex-row gap-4" do
                    Bolt.FieldWrapper orientation: :horizontal do
                      Bolt.RadioButton form, :group, :expense
                      Bolt.Label form, :group, value: :expense
                    end

                    Bolt.FieldWrapper orientation: :horizontal do
                      Bolt.RadioButton form, :group, :income
                      Bolt.Label form, :group, value: :income
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

                div class: "flex flex-row gap-4" do
                  Bolt.FieldWrapper do
                    Bolt.Label form, :amount_cents
                    Bolt.MoneyField form, :amount_cents
                    Bolt.FieldError form, :amount_cents
                  end

                  Bolt.FieldWrapper do
                    Bolt.Label form, :occurred_on
                    Bolt.DateField form, :occurred_on
                    Bolt.FieldError form, :occurred_on
                  end
                end

                Bolt.FieldWrapper do
                  Bolt.Label form, :note
                  Bolt.TextField form, :note
                  Bolt.FieldError form, :note
                end
              end
            end

            Bolt.Stack gap: :sm do
              Bolt.Submit form

              Bolt.LinkButton href: @cancel_href, ghost: true do
                Lucide.ArrowLeft(class: "size-5")
                plain t("Cancel")
              end
            end
          end
        end
      end

      def form_url
        if @record.persisted?
          account_record_path(request.params[:account_id], @record)
        else
          account_records_path
        end
      end
    end
  end
end
