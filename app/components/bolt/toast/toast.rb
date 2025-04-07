module Bolt
  class Toast < Base
    def initialize(color:, **)
      @color = color

      super(**)
    end

    private

    def view_template(&)
      div class: "toast animate-fade-in-up", data: {turbo_temporary: true} do
        Bolt.Alert(color: @color, &)
      end
    end
  end
end
