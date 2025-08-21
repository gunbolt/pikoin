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
        Bolt.Form model: @transfer do |form|
          input type: :hidden,
            name: "account_id",
            value: request.params[:account_id]

          Bolt.Stack do
            form.error_summary

            Bolt.Panel do
              Bolt.Stack do
                div class: "flex flex-row gap-4" do
                  form.field_wrapper do
                    form.label :from_account_id
                    form.collection_select :from_account_id, @accounts, :id, :title
                    form.field_error :from_account_id
                  end

                  form.field_wrapper do
                    form.label :to_account_id
                    form.collection_select :to_account_id, @accounts, :id, :title
                    form.field_error :to_account_id
                  end
                end

                div class: "flex flex-row gap-4" do
                  form.field_wrapper do
                    form.label :amount_cents
                    form.money_field :amount_cents, autofocus: true
                    form.field_error :amount_cents
                  end

                  form.field_wrapper do
                    form.label :occurred_on
                    form.date_field :occurred_on, max: Time.zone.today.iso8601
                    form.field_error :occurred_on
                  end
                end

                form.field_wrapper do
                  form.label :note
                  form.text_field :note
                  form.field_error :note
                end
              end
            end

            Bolt.Stack gap: :sm do
              form.submit

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
