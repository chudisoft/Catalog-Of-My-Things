class Loader
  def load_authors(main)
    return unless File.exist?('json_data/authors.json')

    authors_json = JSON.parse(File.read('json_data/authors.json'))
    authors_json.each do |author_data|
      id = author_data['id']
      first_name = author_data['first_name']
      last_name = author_data['last_name']
      author = Author.new(first_name, last_name, id: id)
      main.authors << author
    end
  end

  def load_games(main)
    return unless File.exist?('json_data/games.json')

    games_json = JSON.parse(File.read('json_data/games.json'))
    games_json.each do |game_data|
      id = game_data['id']
      publish_date = Date.parse(game_data['publish_date'])
      multiplayer = game_data['multiplayer']
      last_played_at = Date.parse(game_data['last_played_at']) # Parse last_played_at as Date
      game = Game.new(publish_date, multiplayer, last_played_at, id: id)
      main.items << game
    end
  end

  def load_books(main)
    return unless File.exist?('json_data/books.json')

    books_json = JSON.parse(File.read('json_data/books.json'))
    books_json.each do |book_data|
      id = book_data['id']
      publish_date = Date.parse(book_data['publish_date'])
      publisher = book_data['publisher']
      cover_state = book_data['cover_state']
      book = Book.new(publish_date, publisher, cover_state, id: id)
      main.items << book
    end
  end

  def load_labels(main)
    return unless File.exist?('json_data/labels.json')

    labels_json = JSON.parse(File.read('json_data/labels.json'))
    labels_json.each do |label_data|
      name = label_data['name']
      color = label_data['color']
      label = Label.new(name, color)
      main.labels << label
    end
  end

  def load_genres(main)
    return unless File.exist?('json_data/genres.json')

    genres_json = JSON.parse(File.read('json_data/genres.json'))
    genres_json.each do |genre_data|
      id = genre_data['id']
      name = genre_data['name']
      genre = Genre.new(id, name) # Fix the order of arguments
      main.genres << genre
    end
  end

  def load_music_albums(main)
    return unless File.exist?('json_data/music_album.json')

    music_albums_json = JSON.parse(File.read('json_data/music_album.json'))
    music_albums_json.each do |music_album_data|
      title = music_album_data['title']
      artist = music_album_data['artist']
      music_album_data['on_spotify']
      release_date = Date.parse(music_album_data['release_date']) # Read and parse the release date
      genre = music_album_data['genre'] # Make sure the 'genre' data is present in the JSON
      music_album = MusicAlbum.new(title, artist, release_date, genre: genre)
      main.music_albums << music_album
      main.items << music_album
    end
  end
end
