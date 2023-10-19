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
require_relative 'create_models'

class Main
  attr_accessor :@authors, :@items, :genres

  def initialize
    @items = []
    @labels = []
    @authors = []
    @genres = []
    @music_album = []
    @running = true

    load_records
    create_models = CreateModels.new(self)
    @actions = [
      -> { create_models.create_item }, -> { move_to_archive },
      -> { list_all_books }, -> { list_all_labels },
      -> { create_models.add_book }, -> { create_models.add_label },
      -> { create_models.add_genre }, -> { create_models.add_music_album }, -> { quit },
      -> { puts 'Invalid option. Please choose a valid option.' }
    ]

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

  def list_all_games
    if @items.empty?
      puts 'No games found.'
    else
      puts 'List of all games:'
      @items.each do |item|
        if item.is_a?(Game)
          puts "ID: #{item.id}, Multiplayer: #{item.multiplayer}, Last played at: #{item.last_played_at}"
        end
      end
    end
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

  def quit
    puts 'Exiting the app.'
    @running = false
  end
end

# Run the application
Main.new
