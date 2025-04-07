module Components
  module Layouts
    class Flash < Base
      COLORS = {
        "notice" => :success,
        "alert" => :error
      }.freeze

      private

      def render? = flash.any?

      def view_template
        flash.each do |type, message|
          Bolt.Toast color: COLORS[type] do
            message
          end
        end
      end
    end
  end
end
