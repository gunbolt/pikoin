module Bolt
  class ColorPicker < Base
    COLORS = %w[
      #122230 #244a63 #6882a8 #b1cbe2
      #d9eaf8 #e1e3d2 #afe4bd #48c39a
      #279098 #333a7f #995fbf #cc88e1
      #f9b9d8 #ed6697 #bb3c63 #692851
      #542730 #9f4444 #d9865d #f6d995
      #efba3f #c6c85f #84b25f #408450
    ].freeze

    CHECK_CLASSES = "hidden peer-checked:flex w-full h-full mask " \
      "items-center justify-center border-[2px] ring-[2px] ring-offset-1 " \
      "ring-base-content rounded-full"

    def initialize(form, attribute, **)
      @form = form
      @attribute = attribute

      super(**)
    end

    private

    def view_template
      div class: "grid grid-cols-6 lg:grid-cols-12 gap-4 lg:gap-2" do
        COLORS.each do |color|
          @form.label(
            @attribute,
            value: color,
            class: "aspect-square rounded-full cursor-pointer relative",
            style: "background-color: #{color}"
          ) do
            @form.radio_button @attribute, color, class: "peer hidden"

            span class: CHECK_CLASSES
          end
        end
      end
    end
  end
end
