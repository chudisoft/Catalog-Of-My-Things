require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(title, artist, release_date, _genre)
    super(release_date)
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
