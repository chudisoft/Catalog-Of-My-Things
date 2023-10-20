require_relative 'item'
require_relative 'genre'

class MusicAlbum < Item
  attr_accessor :on_spotify
  attr_reader :title, :artist, :genre

  def initialize(title, artist, release_date, id: 0)
    super(release_date, id: id)
    @title = title
    @artist = artist
    @on_spotify = false
    @genre = genre
  end

  def on_spotify?
    @on_spotify
  end

  def to_json(*_args)
    {
      'title' => @title,
      'artist' => @artist,
      'on_spotify' => @on_spotify,
      'genre' => @genre.to_json
    }
  end

  private

  def can_be_archived?
    parent_can_be_archived = super
    parent_can_be_archived && @on_spotify
  end
end
