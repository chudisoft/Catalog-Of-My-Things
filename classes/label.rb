require 'json'

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

  def to_json(*_args)
    {
      name: @name,
      color: @color,
      items: @items.map(&:to_json)
    }.to_json
  end
end
