require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :author

  def initialize(id, publish_date, multiplayer, last_played_at, author)
    super(id, publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @author = author
  end
end
