module Components
  module Transfers
    class Form < Base
      def initialize(transfer:, accounts:, cancel_href:)
        @transfer = transfer
        @accounts = accounts
        @cancel_href = cancel_href
      end

      private

      def view_template
        form_with model: @transfer do |form|
          input type: :hidden,
            name: "account_id",
            value: request.params[:account_id]

          Bolt.Stack do
            Bolt.ErrorSummary form

            Bolt.Panel do
              Bolt.Stack do
                div class: "flex flex-row gap-4" do
                  Bolt.FieldWrapper do
                    Bolt.Label form, :from_account_id
                    Bolt.CollectionSelect form, :from_account_id, @accounts,
                      :id, :title
                    Bolt.FieldError form, :from_account_id
                  end

                  Bolt.FieldWrapper do
                    Bolt.Label form, :to_account_id
                    Bolt.CollectionSelect form, :to_account_id, @accounts,
                      :id, :title
                    Bolt.FieldError form, :to_account_id
                  end
                end

                div class: "flex flex-row gap-4" do
                  Bolt.FieldWrapper do
                    Bolt.Label form, :amount_cents
                    Bolt.MoneyField form, :amount_cents, autofocus: true
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
    end
  end
end
