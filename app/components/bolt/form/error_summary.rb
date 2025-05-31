module Bolt
  class ErrorSummary < Base
    WRAPPER_CLASSES = "flex flex-col gap-2 rounded-box border border-dashed " \
      "border-error bg-base-100 p-4 text-error shadow-sm"

    def initialize(form, **)
      @form = form

      super(**)
    end

    private

    def render? = record.errors.any?

    def view_template(&)
      div class: WRAPPER_CLASSES, data: {turbo_temporary: true} do
        div class: "flex flex-row items-center gap-2" do
          Lucide.CircleX
          span(class: "font-bold") do
            t("Something’s not quite right")
          end
        end

        ul class: "list-inside list-disc pl-8 text-sm" do
          record.errors.to_hash.each do |attribute, messages|
            li { build_error_message(attribute, messages) }
          end
        end
      end
    end

    def record = @form.object

    def build_error_message(attribute, messages)
      "#{record.class.human_attribute_name(attribute)} #{messages.to_sentence}"
    end
  end
end
