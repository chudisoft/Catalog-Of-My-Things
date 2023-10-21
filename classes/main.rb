require 'json'
require 'date'
require_relative 'item'
require_relative 'game'
require_relative 'author'
require_relative 'book'
require_relative 'label'
require_relative 'genre'
require_relative 'music_album'
require_relative 'create_models'
require_relative 'loader'
require_relative 'list_all'

class Main
  attr_accessor :authors, :items, :genres, :labels, :music_albums

  def initialize
    @authors = []
    @items = [] # Initialize @items as an empty array
    @music_albums = []
    @genres = []
    @labels = []

    @create_models = CreateModels.new(self)
    @list_all = ListAll.new(self)
    @actions = actions

    load_records
    run
  end

  private

  def run
    print_options
    option = gets.chomp.to_i
    @actions[option - 1].call
    run unless option == 11
  end

  def actions
    [
      -> { move_to_archive },
      -> { @list_all.list_all_books },
      -> { @list_all.list_all_labels },
      -> { @list_all.list_all_games },
      -> { @list_all.list_all_authors },
      -> { @list_all.list_all_genres },
      -> { @list_all.list_all_albums },
      -> { @create_models.add_book },
      -> { @create_models.add_music_album },
      -> { @create_models.add_game },
      -> { quit },
      -> { puts 'Invalid option. Please choose a valid option.' }
    ]
  end

  def print_options
    puts 'Options:'
    puts '1. Move Item to Archive'
    puts '2. List all books'
    puts '3. List all labels'
    puts '4. List all games'
    puts '5. List all authors'
    puts '6. List all genres'
    puts '7. List all albums'
    puts '8. Add a book'
    puts '9. Add a music album'
    puts '10. Add a game'
    puts '11. Quit'

    print 'Choose an option: '
  end

  def load_records
    ensure_json_data_directory
    load = Loader.new
    load.load_authors(self)
    load.load_games(self)
    load.load_books(self)
    load.load_labels(self)
    load.load_genres(self)
    load.load_music_albums(self)
  end

  def ensure_json_data_directory
    return if Dir.exist?('json_data')

    Dir.mkdir('json_data')
  end

  def move_to_archive
    print 'Enter the ID of the item to move to the archive: '
    item_id = gets.chomp.to_i
    item = @items.find { |i| i.id == item_id }

    if item
      item.move_to_archive
      puts "Item with ID #{item.id} moved to the archive."
    else
      puts "Item with ID #{item_id} not found."
    end
  end

  def quit
    puts 'Exiting the app.'
    save_all_music_albums
  end

  def add_game
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Is it multiplayer? (true/false): '
    multiplayer = gets.chomp.downcase == 'true'
    print 'Enter the date last played (YYYY-MM-DD): '
    last_played_at = Date.parse(gets.chomp)

    game = Game.new(publish_date, multiplayer, last_played_at)
    @items << game # Append the game to the @items array

    # Add author to the game
    print 'Enter author first_name for the game: '
    first_name = gets.chomp
    print 'Enter author last_name for the game: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    game.add_author(author)

    puts '*******************************************************************'
    puts "Game added with ID: #{game.id}"
    # Removed the save_games method call
    puts '*******************************************************************'
  end

  def save_all_music_albums
    @music_albums.each { |music_album| save_music_album(music_album) }
  end

  def save_music_album(music_album)
    data_to_save = {
      id: music_album.id,
      title: music_album.title,
      artist: music_album.artist,
      on_spotify: music_album.on_spotify,
      genre: music_album.genre
    }

    serialized_data = JSON.generate(data_to_save)
    filename = "music_album_#{music_album.id}.json"

    File.write(filename, serialized_data)

    puts "Music album with ID #{music_album.id} saved to #{filename}"
  end
end

# Run the application
Main.new
