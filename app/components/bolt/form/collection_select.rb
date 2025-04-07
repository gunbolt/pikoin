module Bolt
  class CollectionSelect < Base
    def initialize(
      form,
      attribute,
      collection,
      value_method,
      text_method,
      options = {},
      **
    )
      @form = form
      @attribute = attribute
      @collection = collection
      @value_method = value_method
      @text_method = text_method
      @options = options

      super(**)
    end

    private

    def view_template
      @form.collection_select(
        @attribute,
        @collection,
        @value_method,
        @text_method,
        @options,
        class: "select w-full",
        **@attributes
      )
    end
  end
end
