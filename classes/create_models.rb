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
    @items = @main.items
    @music_albums = @main.items
  end

  def create_item
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    item = Item.new(publish_date)
    @main.items << item
    puts "Item created with ID: #{item.id}"
  end

  def create_genre
    puts 'Enter the genre name:'
    genre_name = gets.chomp
    Genre.new(0, genre_name)
  end

  def save_games
    games_json = @items.select { |item| item.is_a?(Game) }.map(&:to_json)
    File.write('json_data/games.json', JSON.pretty_generate(games_json))

    puts 'Games saved as JSON. Debug message.'
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
    labels_hashes = @main.labels.map(&:to_json)
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
    music_albums_json = @music_albums.select { |item| item.is_a?(MusicAlbum) }.map(&:to_json)
    File.write('json_data/music_album.json', JSON.pretty_generate(music_albums_json))

    puts 'Music Albums saved as JSON.'
  end

  def save_books
    books_json = @main.items.select { |item| item.is_a?(Book) }.map(&:to_json)
    File.write('json_data/books.json', JSON.pretty_generate(books_json))
    puts 'Books saved as JSON.'
  end

  def add_game
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Is it multiplayer? (true/false): '
    multiplayer = gets.chomp.downcase == 'true'
    print 'Enter the date last played (YYYY-MM-DD): '
    last_played_at = Date.parse(gets.chomp)

    game = Game.new(publish_date, multiplayer, last_played_at)
    @items << game

    # Add author to the game
    print 'Enter author first_name for the game: '
    first_name = gets.chomp
    print 'Enter author last_name for the game: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    game.add_author(author)
    # Save the game with author information
    save_games
    puts '*******************************************************************'
    puts "Game added with ID: #{game.id}"

    puts '*******************************************************************'
  end

  def add_author
    print 'Enter author first_name: '
    first_name = gets.chomp
    print 'Enter author last_name: '
    last_name = gets.chomp

    author = Author.new(first_name, last_name)
    @main.authors << author
    puts '*******************************************************************'
    puts "Author added: #{author.first_name} #{author.last_name}"
    save_authors
    puts '*******************************************************************'
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

    # Add labels to the book
    print 'Enter label name for the book: '
    label_name = gets.chomp
    label = Label.new(label_name, 'label_color') # Modify as needed
    book.add_label(label)

    # Add author to the book
    print 'Enter author first_name for the book: '
    first_name = gets.chomp
    print 'Enter author last_name for the book: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    book.add_author(author)

    puts '*******************************************************************'
    puts "Book added with ID: #{book.id}"
    save_books
    puts '*******************************************************************'
  end

  def add_genre
    print 'Enter genre name: '
    name = gets.chomp

    genre = Genre.new(0, name)
    @main.genres << genre
    puts '*******************************************************************'
    puts "Genre added with ID: #{genre.id}"
    puts "Genre added with ID: #{genre.name}"
    save_genres
    puts '*******************************************************************'
  end

  def add_music_album
    print 'Enter the title of the music album: '
    title = gets.chomp

    print 'Enter the artist of the music album: '
    artist = gets.chomp

    print 'Is the music album on Spotify? (true/false): '
    gets.chomp

    print 'Enter the release date of the music album (YYYY-MM-DD): '
    release_date = gets.chomp
    publish_date = Date.parse(release_date)

    print 'Enter label name for the music album: '
    label_name = gets.chomp

    # Add a color for the label
    print 'Enter label color: '
    label_color = gets.chomp

    label = Label.new(label_name, label_color)

    print 'Enter genre name for the music album: '
    gets.chomp

    # Create a new Genre object and add it to the music_album
    genre = create_genre

    music_album = MusicAlbum.new(title, artist, publish_date)
    music_album.add_label(label)
    music_album.add_genre(genre)

    save_music_album

    @music_albums << music_album

    puts '*******************************************************************'
    puts "Music Album added with ID: #{music_album.id}"
  end

  def add_label
    print 'Enter label name: '
    name = gets.chomp
    print 'Enter label color: '
    color = gets.chomp

    label = Label.new(name, color)
    @main.labels << label
    puts '*******************************************************************'
    puts "Label added: #{label.name}"
    save_labels
    puts '*******************************************************************'
  end
end
