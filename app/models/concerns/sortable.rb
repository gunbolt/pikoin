module Sortable
  extend ActiveSupport::Concern

  class_methods do
    def next_position = maximum(:position).to_i + 1
  end
end
