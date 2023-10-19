require 'json'
require 'date'
require_relative 'item'
require_relative 'game'
require_relative 'author'
require_relative 'book'
require_relative 'label'
require_relative 'genre'
require_relative 'music_album'
require_relative 'loader'

class Main
  attr_accessor :@authors, :@items
  def initialize
    @actions = [
      -> { create_item }, -> { move_to_archive },
      -> { list_all_books }, -> { list_all_labels },
      -> { add_book }, -> { add_label }, -> { add_genre }, -> { add_music_album }, -> { quit },
      -> { puts 'Invalid option. Please choose a valid option.' }
    ]

    @items = []
    @labels = []
    @authors = []
    @music_album = []
    @running = true

    load_records

    while @running
      print_options
      option = gets.chomp.to_i
      @actions[option - 1].call
    end
  end

  private

  def print_options
    puts 'Options:'
    puts '1. Create Item'
    puts '2. Move Item to Archive'
    puts '3. List all books'
    puts '4. List all labels'
    puts '5. Add a book'
    puts '6. Add a label'
    puts '7. Add a genre'
    puts '8. Add a music album'
    puts '9. Quit'

    print 'Choose an option: '
  end

  def load_records
    ensure_json_data_directory
    Loader.load_books(self)
    Loader.load_labels(self)
    Loader.load_genres(self)
    Loader.load_music_albums(self)
  end

  def ensure_json_data_directory
    return if Dir.exist?('json_data')

    Dir.mkdir('json_data')
  end

  def create_item
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    item = Item.new(publish_date)
    @items << item
    puts "Item created with ID: #{item.id}"
  end

  def move_to_archive
    print 'Enter the ID of the item to move to archive: '
    item_id = gets.chomp.to_i
    item = @items.find { |i| i.id == item_id }

    if item
      item.move_to_archive
      puts "Item with ID #{item.id} moved to the archive."
    else
      puts "Item with ID #{item_id} not found."
    end
  end

  def save_games
    # Save games to a JSON file
    games_json = @items.select { |item| item.is_a?(Game) }.map(&:to_json)
    File.write('json_data/games.json', JSON.pretty_generate(games_json))

    puts 'Games saved as JSON.'
  end

  def save_authors
    # Save labels to a JSON file
    authors_hashes = @authors.map(&:to_json)
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

  def list_all_games
    if @items.empty?
      puts 'No games found.'
    else
      puts 'List of all games:'
      @items.each do |item|
        puts "ID: #{item.id}, Multiplayer: #{item.multiplayer}, Last played at: #{item.last_played_at}" if item.is_a?(Game)
      end
    end
  end

  def save_genres
    genres_json = @items.select { |item| item.is_a?(Genre) }.map(&:to_json)
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
    books_json = @items.select { |item| item.is_a?(Book) }.map(&:to_json)
    File.write('json_data/books.json', JSON.pretty_generate(books_json))

    puts 'Books saved as JSON.'
  end

  def list_all_books
    if @items.empty?
      puts 'No books found.'
    else
      puts 'List of all books:'
      @items.each do |item|
        puts "ID: #{item.id}, Publisher: #{item.publisher}, Cover State: #{item.cover_state}" if item.is_a?(Book)
      end
    end
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels found.'
    else
      puts 'List of all labels:'
      @labels.each do |label|
        puts "Name: #{label.name}, Color: #{label.color}"
      end
    end
  end

  def add_game
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Enter publisher: '
    multiplayer = gets.chomp
    print 'Enter cover state: '
    last_played_at = gets.chomp

    game = Game.new(publish_date, multiplayer, last_played_at)
    @items << game
    puts "Game added with ID: #{game.id}"
    save_games
  end

  def add_author
    print 'Enter author first_name: '
    first_name = gets.chomp
    print 'Enter author last_name: '
    last_name = gets.chomp

    author = Author.new(first_name, last_name)
    @authors << author
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
    @items << book
    puts "Book added with ID: #{book.id}"
    save_books
  end

  def add_genre
    print 'Enter genre name: '
    name = gets.chomp

    genre = Genre.new(0, name)
    @items << genre
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
    @music_album << music_album
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

  def quit
    puts 'Exiting the app.'
    @running = false
  end
end

# Run the application
Main.new
