require_relative 'item'
require_relative 'game'
require_relative 'author'
require_relative 'book'
require_relative 'label'
require_relative 'genre'
require_relative 'music_album'

class CreateModels
  def initialize(main)
    @main = main
  end

  def create_item
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    item = Item.new(publish_date)
    @main.items << item
    puts "Item created with ID: #{item.id}"
  end

  def save_games
    # Save games to a JSON file
    games_json = @main.items.select { |item| item.is_a?(Game) }.map(&:to_json)
    File.write('json_data/games.json', JSON.pretty_generate(games_json))

    puts 'Games saved as JSON.'
  end

  def save_authors
    # Save labels to a JSON file
    authors_hashes = @main.authors.map(&:to_json)
    authors_json = JSON.pretty_generate(authors_hashes)
    File.write('json_data/authors.json', authors_json)

    puts 'Authors saved as JSON.'
  end

  def save_labels
    # Save labels to a JSON file
    labels_hashes = @labels.map(&:to_json)
    labels_json = JSON.pretty_generate(labels_hashes)
    File.write('json_data/labels.json', labels_json)

    puts 'Labels saved as JSON.'
  end

  def save_genres
    genres_json = @main.genres.select { |item| item.is_a?(Genre) }.map(&:to_json)
    File.write('json_data/genres.json', JSON.pretty_generate(genres_json))

    puts 'Genres saved as JSON.'
  end

  def save_music_album
    music_album_json = @music_album.map(&:to_json)
    File.write('json_data/music_album.json', JSON.pretty_generate(music_album_json))

    puts 'Music Albums saved as JSON.'
  end

  def save_books
    # Save books to a JSON file
    books_json = @main.items.select { |item| item.is_a?(Book) }.map(&:to_json)
    File.write('json_data/books.json', JSON.pretty_generate(books_json))

    puts 'Books saved as JSON.'
  end

  def add_game
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Enter publisher: '
    multiplayer = gets.chomp
    print 'Enter cover state: '
    last_played_at = gets.chomp

    game = Game.new(publish_date, multiplayer, last_played_at)
    @main.items << game
    puts "Game added with ID: #{game.id}"
    save_games
  end

  def add_author
    print 'Enter author first_name: '
    first_name = gets.chomp
    print 'Enter author last_name: '
    last_name = gets.chomp

    author = Author.new(first_name, last_name)
    @main.authors << author
    puts "Author added: #{author.name}"
    save_authors
  end

  def add_book
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Enter publisher: '
    publisher = gets.chomp
    print 'Enter cover state: '
    cover_state = gets.chomp

    book = Book.new(publish_date, publisher, cover_state)
    @main.items << book
    puts "Book added with ID: #{book.id}"
    save_books
  end

  def add_genre
    print 'Enter genre name: '
    name = gets.chomp

    genre = Genre.new(0, name)
    @main.genres << genre
    puts "Genre added with ID: #{genre.id}"
    save_genres
  end

  def add_music_album
    print 'Enter the title of the music album: '
    title = gets.chomp
    print 'Enter the artist of the music album: '
    artist = gets.chomp
    print 'Is the music album on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'
    print 'Enter the genre of the music album: '
    genre = gets.chomp

    music_album = MusicAlbum.new(title, artist, on_spotify, genre)
    @main.items << music_album
    puts "Music Album added with ID: #{music_album.id}"
    save_music_album
  end

  def add_label
    print 'Enter label name: '
    name = gets.chomp
    print 'Enter label color: '
    color = gets.chomp

    label = Label.new(name, color)
    @labels << label
    puts "Label added: #{label.name}"
    save_labels
  end
end
