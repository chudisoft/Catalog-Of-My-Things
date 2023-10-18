require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(title, artist, release_date, genre)
    super(title, genre, nil, nil, release_date)
    @title = title
    @artist = artist
    @on_spotify = false
  end

  def on_spotify?
    @on_spotify
  end

  private

  def can_be_archived?
    parent_can_be_archived = super
    parent_can_be_archived && @on_spotify
  end
end
