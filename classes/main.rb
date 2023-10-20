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
  attr_accessor :authors, :items, :genres, :labels

  def initialize
    @authors = []
    @items = []
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
    run unless option == 15
  end

  def actions
    [
      -> { @create_models.create_item }, -> { move_to_archive },
      -> { @list_all.list_all_books }, -> { @list_all.list_all_labels },
      -> { @list_all.list_all_games }, -> { @list_all.list_all_authors },
      -> { @list_all.list_all_genre }, -> { @list_all.list_all_albums },
      -> { @create_models.add_book }, -> { @create_models.add_label },
      -> { @create_models.add_genre }, -> { @create_models.add_music_album },
      -> { @create_models.add_author }, -> { @create_models.add_game },
      -> { quit }, -> { puts 'Invalid option. Please choose a valid option.' }
    ]
  end

  def print_options
    puts 'Options:'
    puts '1. Create Item'
    puts '2. Move Item to Archive'
    puts '3. List all books'
    puts '4. List all labels'
    puts '5. List all games'
    puts '6. List all authors'
    puts '7. List all genres'
    puts '8. List all albums'
    puts '9. Add a book'
    puts '10. Add a label'
    puts '11. Add a genre'
    puts '12. Add a music album'
    puts '13. Add an author'
    puts '14. Add a game'
    puts '15. Quit'

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

  def quit
    puts 'Exiting the app.'
    @running = false
  end
end

# Run the application
Main.new
