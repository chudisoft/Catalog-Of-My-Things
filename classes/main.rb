require 'json'
require 'date'
require_relative 'item'
require_relative 'book'
require_relative 'label'

class Main
  def initialize
    @actions = [
      -> { create_item }, -> { move_to_archive },
      -> { list_all_books }, -> { list_all_labels },
      -> { add_book }, -> { add_label }, -> { quit },
      -> { puts 'Invalid option. Please choose a valid option.' }
    ]
    @items = []
    @labels = []
    @running = true # Initialize the app as running

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
    puts '7. Quit'

    print 'Choose an option: '
  end

  def load_records
    load_books
    load_labels
  end

  def load_books
    return unless File.exist?('json_data/books.json')

    books_json = JSON.parse(File.read('json_data/books.json'))
    books_json.each do |book_data|
      id = book_data['id']
      publish_date = Date.parse(book_data['publish_date'])
      publisher = book_data['publisher']
      cover_state = book_data['cover_state']
      book = Book.new(publish_date, publisher, cover_state, id: id)
      @items << book
    end
  end

  def load_labels
    return unless File.exist?('json_data/labels.json')

    labels_json = JSON.parse(File.read('json_data/labels.json'))
    labels_json.each do |label_data|
      name = label_data['name']
      color = label_data['color']
      label = Label.new(name, color)
      @labels << label
    end
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

  def save_books
    # Save books to a JSON file
    books_json = @items.select { |item| item.is_a?(Book) }.map(&:to_json)
    File.write('json_data/books.json', JSON.pretty_generate(books_json))

    puts 'Books saved as JSON.'
  end

  def save_labels
    # Save labels to a JSON file
    labels_hashes = @labels.map(&:to_json)
    labels_json = JSON.pretty_generate(labels_hashes)
    File.write('json_data/labels.json', labels_json)

    puts 'Labels saved as JSON.'
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
