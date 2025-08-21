module Components
  module Categories
    class Form < Base
      def initialize(category:)
        @category = category
      end

      private

      def view_template
        Bolt.Form model: @category do |form|
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
              end
            end

            Bolt.Stack gap: :sm do
              form.submit

              Bolt.LinkButton href: categories_path, ghost: true do
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
