module Components
  module Templates
    class ListItem < Base
      def initialize(template:)
        @template = template
        @category = template.category
        @account = template.account
      end

      private

      def view_template
        Bolt.ListItem padding: nil, data: {id: @template.id} do
          div class: "flex flex-row gap-2 items-center px-4" do
            div class: "cursor-move sortable-handle" do
              Lucide.GripVertical class: "size-6 stroke-base-content/60"
            end

            a(
              href: edit_template_path(@template),
              class: "flex flex-row gap-2 items-center justify-between w-full py-4"
            ) do
              div class: "flex flex-col gap-2" do
                span class: "font-bold" do
                  @template.title
                end

                div class: "flex flex-row items-center gap-2" do
                  Bolt.Dot(
                    size: "size-8",
                    color: @category.color,
                    title: @category.title
                  )

                  div class: "flex flex-col" do
                    span class: "text-lg font-semibold" do
                      @category.title
                    end

                    span class: "text-current/50 text-xs" do
                      @template.note
                    end
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

                  span class: "text-sm text-current/50" do
                    @account.title
                  end
                end

                Bolt.CurrencyDisplay(amount: @template.amount)
              end
            end
          end
        end
      end
    end
  end
end
