module Components
  module Templates
    class List < Base
      def initialize(templates:)
        @templates = templates
      end

      private

      def view_template
        Bolt.List(
          data: {
            controller: "sortable",
            sortable_endpoint_value: ordering_path(Template.name.parameterize)
          }
        ) do
          @templates.each { ListItem(template: it) }
        end
      end
    end
  end
end
