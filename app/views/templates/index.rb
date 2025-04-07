module Views
  module Templates
    class Index < Views::Base
      def initialize(templates:)
        @templates = templates
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end

              if @templates.any?
                Bolt.PageActions do
                  Bolt.LinkButton href: new_template_path, color: :primary do
                    Lucide.Plus class: "size-4"
                    plain t(".new_template")
                  end
                end
              end
            end

            Bolt.PageBody do
              if @templates.any?
                Components::Templates.List(templates: @templates)
              else
                Components::Templates.EmptyState
              end
            end
          end
        end
      end
    end
  end
end
