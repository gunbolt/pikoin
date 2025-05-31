module Components
  module Accounts
    class Form < Base
      def initialize(account:)
        @account = account
      end

      private

      def view_template
        form_with model: @account do |form|
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
                  Bolt.Label form, :color
                  Bolt.ColorPicker form, :color
                  Bolt.FieldError form, :color
                end

                Bolt.FieldWrapper do
                  Bolt.Label form, :initial_amount_cents
                  Bolt.MoneyField form, :initial_amount_cents,
                    allow_negative: true
                  Bolt.FieldError form, :initial_amount_cents
                end

                if @account.persisted?
                  Bolt.FieldWrapper do
                    Bolt.Label form, :archived
                    Bolt.Toggle form, :archived
                    Bolt.FieldError form, :archived
                  end
                end
              end
            end

            Bolt.Stack gap: :sm do
              Bolt.Submit form

              Bolt.LinkButton href: cancel_href, ghost: true do
                Lucide.ArrowLeft(class: "size-5")
                plain t("Cancel")
              end
            end
          end
        end
      end

      def cancel_href
        if @account.new_record?
          accounts_path
        else
          account_records_path(@account)
        end
      end
    end
  end
end
