class Author
  attr_reader :id, :first_name, :last_name
  attr_accessor :items

  def initialize(first_name, last_name, id: 0)
    @id = id <= 0 ? rand(1..200) : id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_items(item)
    @items << item
    item.add_author(self)
  end

  def to_json(*_args)
    {
      'id' => @id,
      'first_name' => @first_name,
      'last_name' => @last_name,
      'items' => @items.map(&:to_json)
    }
  end
end
