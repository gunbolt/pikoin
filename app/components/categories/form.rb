module Components
  module Categories
    class Form < Base
      def initialize(category:)
        @category = category
      end

      private

      def view_template
        form_with model: @category do |form|
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
              end
            end

            Bolt.Stack gap: :sm do
              Bolt.Submit form

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
