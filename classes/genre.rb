class Genre
  attr_reader :id, :name
  attr_accessor :items

  def initialize(_id, name)
    @id = rand(1..200)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end
end
