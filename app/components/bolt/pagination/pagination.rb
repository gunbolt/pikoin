module Bolt
  class Pagination < Base
    def initialize(pagy:, **)
      @pagy = pagy

      super(**)
    end

    private

    def view_template
      div class: "flex flex-row gap-2 justify-between" do
        if @pagy.prev.present?
          link_to({page: @pagy.prev}, class: "btn btn-ghost") do
            Lucide.ArrowLeft(class: "size-4")
            plain t("Previous")
          end
        else
          button class: "btn btn-ghost cursor-not-allowed", disabled: true do
            Lucide.ArrowLeft(class: "size-4")
            plain t("Previous")
          end
        end

        if @pagy.next.present?
          link_to({page: @pagy.next}, class: "btn btn-ghost") do
            plain t("Next")
            Lucide.ArrowRight(class: "size-4")
          end
        else
          button class: "btn btn-ghost cursor-not-allowed", disabled: true do
            plain t("Next")
            Lucide.ArrowRight(class: "size-4")
          end
        end
      end
    end
  end
end
