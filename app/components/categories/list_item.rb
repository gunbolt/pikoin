module Components
  module Categories
    class ListItem < Base
      def initialize(category:)
        @category = category
      end

      private

      def view_template
        Bolt.ListItem padding: nil, data: {id: @category.id} do
          div class: "flex flex-row gap-2 items-center px-4" do
            div class: "cursor-move sortable-handle" do
              Lucide.GripVertical class: "size-6 stroke-base-content/60"
            end

            a(
              href: edit_category_path(@category),
              class: "flex flex-row gap-2 items-center w-full py-4"
            ) do
              Bolt.Dot(
                size: "size-6",
                color: @category.color,
                title: @category.title
              )

              span class: "text-lg font-semibold" do
                @category.title
              end
            end
          end
        end
      end
    end
  end
end
