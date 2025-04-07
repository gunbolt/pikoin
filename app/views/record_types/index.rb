module Views
  module RecordTypes
    class Index < Views::Base
      def initialize(templates:)
        @templates = templates
      end

      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end
            end

            Bolt.PageBody do
              Bolt.Stack do
                record_types_grid

                Bolt.LinkButton(
                  href: account_records_path(request.params[:account_id]),
                  ghost: true
                ) do
                  Lucide.ArrowLeft(class: "size-4")
                  plain t("cancel")
                end
              end
            end
          end
        end
      end

      def record_types_grid
        div class: "grid grid-cols-3 gap-2" do
          grid_item(
            href: new_account_record_path(
              request.params[:account_id],
              group: :expense
            )
          ) do
            Lucide.Minus(class: "size-5 stroke-3")
            span { t("expense") }
          end

          grid_item(
            href: new_account_record_path(
              request.params[:account_id],
              group: :income
            )
          ) do
            Lucide.Plus(class: "size-5 stroke-3")
            span { t("income") }
          end

          grid_item(
            href: new_transfer_path(
              account_id: request.params[:account_id]
            )
          ) do
            Lucide.ArrowLeftRight(class: "size-5 stroke-3")
            span { t("transfer") }
          end

          @templates.each do |template|
            grid_item(
              href: new_account_record_path(
                request.params[:account_id],
                template: template.id
              )
            ) do
              Lucide.BookDashed(class: "size-5 stroke-3")
              span { template.title }
            end
          end
        end
      end

      def grid_item(href:, &)
        a href: href, class: "hover:cursor-pointer hover:[&>div]:bg-base-300" do
          Bolt.Panel class: "aspect-video justify-center" do
            div class: "flex flex-col items-center gap-2 font-semibold", &
          end
        end
      end
    end
  end
end
