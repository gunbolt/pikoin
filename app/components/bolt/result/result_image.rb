module Bolt
  class ResultImage < Base
    private

    def view_template(&)
      div class: "flex items-center justify-center p-4" do
        img class: ["h-48 w-auto ", @extra_classes], **@attributes
      end
    end
  end
end
