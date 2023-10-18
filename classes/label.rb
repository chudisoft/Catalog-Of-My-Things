class Label
  attr_reader :name, :color
  attr_accessor :items

  def initialize(name, color)
    @name = name
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_label(self)
  end
end
