module Components
  module Records
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("records-empty-state.svg")

          Bolt.ResultTitle do
            t("This account doesn't have records yet")
          end

          Bolt.ResultDescription do
            t("Keep track of your account activity by adding transactions")
          end

          Bolt.ResultActions do
            Bolt.LinkButton(
              href: record_types_path(account_id: request.params[:account_id]),
              color: :primary
            ) do
              t("New record")
            end
          end
        end
      end
    end
  end
end
