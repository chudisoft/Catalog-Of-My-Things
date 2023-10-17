class Label
  attr_reader :name, :color
  attr_accessor :items

  def initialize(name, color)
    @name = name
    @color = color
    @items = []
  end
end
