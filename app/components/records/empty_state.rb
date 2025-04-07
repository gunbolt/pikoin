module Components
  module Records
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("records-empty-state.svg")

          Bolt.ResultTitle { t(".title") }
          Bolt.ResultDescription { t(".description") }

          Bolt.ResultActions do
            Bolt.LinkButton(
              href: record_types_path(account_id: request.params[:account_id]),
              color: :primary
            ) do
              t(".new_record")
            end
          end
        end
      end
    end
  end
end
