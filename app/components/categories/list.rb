module Components
  module Categories
    class List < Base
      def initialize(categories:)
        @categories = categories
      end

      private

      def view_template
        Bolt.List(
          data: {
            controller: "sortable",
            sortable_endpoint_value: ordering_path(Category.name.parameterize)
          }
        ) do
          @categories.each { ListItem(category: it) }
        end
      end
    end
  end
end
