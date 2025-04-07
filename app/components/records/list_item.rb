module Components
  module Records
    class ListItem < Base
      def initialize(record:)
        @record = record
        @category = record.category
        @account = record.account
      end

      private

      def view_template
        a href: edit_path do
          Bolt.ListItem do
            div class: "flex flex-row gap-2 items-center justify-between" do
              div class: "flex flex-row items-center gap-2" do
                main_dot

                div class: "flex flex-col" do
                  span class: "text-lg font-semibold" do
                    main_text
                  end

                  span class: "text-current/50 text-xs" do
                    @record.note
                  end
                end
              end

              div class: "flex flex-col gap-1 items-end" do
                div class: "flex flex-row items-center gap-1" do
                  Bolt.Dot(
                    size: "size-3",
                    color: @account.color,
                    title: @account.title
                  )

                  span class: "text-sm" do
                    @account.title
                  end
                end

                Bolt.CurrencyDisplay(
                  amount: @record.amount,
                  color: @record.transfer_id? ? "text-current" : nil
                )
              end
            end
          end
        end
      end

      def edit_path
        if @record.transfer_id?
          edit_transfer_path(@record.transfer_id, account_id: @account.id)
        else
          edit_account_record_path(@account, @record)
        end
      end

      def main_dot
        if @record.transfer_id?
          transfer_dot
        else
          category_dot
        end
      end

      def main_text
        @record.transfer_id? ? t("transfer") : @category.title
      end

      def transfer_dot
        Bolt.Dot size: "size-8", color: "", title: t("transfer") do
          Lucide.ArrowLeftRight(class: "size-6")
        end
      end

      def category_dot
        Bolt.Dot(size: "size-8", color: @category.color, title: @category.title)
      end
    end
  end
end
