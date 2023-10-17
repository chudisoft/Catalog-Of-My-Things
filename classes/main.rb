require_relative 'item'
class Main
  def initialize
    @items = [] # Create an empty array to store items
    @running = true # Initialize the app as running

    while @running
      puts 'Options:'
      puts '1. Create Item'
      puts '2. Move Item to Archive'
      puts '3. Quit'

      print 'Choose an option: '
      option = gets.chomp.to_i

      case option
      when 1
        create_item
      when 2
        move_to_archive
      when 3
        quit
      else
        puts 'Invalid option. Please choose a valid option.'
      end
    end
  end

  private

  def create_item
    print 'Enter publish date (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    item = Item.new(nil, publish_date)
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

  def quit
    puts 'Exiting the app.'
    @running = false
  end
end

# Run the application
Main.new
