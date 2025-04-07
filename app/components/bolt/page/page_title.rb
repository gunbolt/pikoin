module Bolt
  class PageTitle < Base
    def initialize(drawer_toggle: true, **)
      @drawer_toggle = drawer_toggle

      super(**)
    end

    private

    def view_template(&)
      div class: "flex flex-row items-center gap-2" do
        Bolt.DrawerToggle if @drawer_toggle
        h1 class: ["text-primary font-extrabold text-2xl", @extra_classes], &
      end
    end
  end
end
