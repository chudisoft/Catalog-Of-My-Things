class Loader
  def self.load_music_albums(main)
    return unless File.exist?('json_data/music_album.json')

    music_album_json = JSON.parse(File.read('json_data/music_album.json'))
    music_album_json.each do |music_album_data|
      title = music_album_data['title']
      artist = music_album_data['artist']
      on_spotify = music_album_data['on_spotify']
      genre = music_album_data['genre']
      music_album = MusicAlbum.new(title, artist, on_spotify, genre)
      main.instance_variable_get(:@music_album) << music_album
    end
  end

  def load_authors
    return unless File.exist?('json_data/authors.json')

    authors_json = JSON.parse(File.read('json_data/authors.json'))
    authors_json.each do |author_data|
      id = author_data['id']
      first_name = author_data['first_name']
      last_name = author_data['last_name']
      author = Author.new(first_name, last_name, id: id)
      main.instance_variable_get(:@authors) << author
    end
  end

  def load_games
    return unless File.exist?('json_data/games.json')

    games_json = JSON.parse(File.read('json_data/games.json'))
    games_json.each do |game_data|
      id = game_data['id']
      publish_date = Date.parse(book_data['publish_date'])
      multiplayer = book_data['multiplayer']
      last_played_at = book_data['last_played_at']
      game = Game.new(publish_date, multiplayer, last_played_at, id: id)
      main.instance_variable_get(:@items) << game
    end
  end
end
