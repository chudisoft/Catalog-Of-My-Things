require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(title, artist, release_date, genre)
    super(title, genre, nil, nil, release_date)
    @title = title
    @artist = artist
    @on_spotify = false
  end
end
