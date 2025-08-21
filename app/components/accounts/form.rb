module Components
  module Accounts
    class Form < Base
      def initialize(account:)
        @account = account
      end

      private

      def view_template
        Bolt.Form model: @account do |form|
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
                  form.label :color
                  form.color_picker :color
                  form.field_error :color
                end

                form.field_wrapper do
                  form.label :initial_amount_cents
                  form.money_field :initial_amount_cents, allow_negative: true
                  form.field_error :initial_amount_cents
                end

                if @account.persisted?
                  form.field_wrapper do
                    form.label :archived
                    form.toggle :archived
                    form.field_error :archived
                  end
                end
              end
            end

            Bolt.Stack gap: :sm do
              form.submit

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
