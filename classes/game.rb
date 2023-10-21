require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :author

  def initialize(publish_date, multiplayer, last_played_at, id: 0)
    super(publish_date, id: id)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && (Date.today - Date.parse(@last_played_at)).to_i > 365 * 2
  end

  # def to_json(*_args)
  #   {
  #     'id' => @id,
  #     'genre' => @genre,
  #     'author' => @author,
  #     'source' => @source,
  #     'label' => @label,
  #     'publish_date' => @publish_date,
  #     'archived' => @archived,
  #     'multiplayer' => @multiplayer,
  #     'last_played_at' => @last_played_at
  #   }
  # end

  def to_json(*_args)
    {
      id: @id,
      publish_date: @publish_date.to_s,
      multiplayer: @multiplayer,
      last_played_at: @last_played_at.to_s,
      author: @author.map(&:to_json),
      label: @label.map(&:to_json)
    }
  end
end
