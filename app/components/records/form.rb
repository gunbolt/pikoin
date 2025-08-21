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
        Bolt.Form model: @record, url: form_url do |form|
          Bolt.Stack do
            form.error_summary

            Bolt.Panel do
              Bolt.Stack do
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
                    form.collection_select :account_id, @accounts, :id, :title
                    form.field_error :account_id
                  end

                  form.field_wrapper do
                    form.label :category_id
                    form.collection_select :category_id, @categories, :id, :title
                    form.field_error :category_id
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
