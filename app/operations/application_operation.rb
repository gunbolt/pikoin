class ApplicationOperation
  extend Literal::Properties

  Id = _Union(String, Integer)

  def self.call(...) = new(...).call

  class Result < Literal::Data
    def self.[](...) = new(...)

    def self.define(**properties)
      Class.new(self) do
        properties.each { |name, type| prop(name, type) }
      end
    end
  end
end
