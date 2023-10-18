require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :author

  def initialize(id, publish_date, multiplayer, last_played_at)
    super(id, publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @author = author
  end

  def can_be_archived?
    super && (Date.today - Date.parse(@last_played_at)).to_i > 365 * 2
  end
end
