require_relative 'item'
require_relative 'game'
require_relative 'author'
require_relative 'book'
require_relative 'label'
require_relative 'genre'
require_relative 'music_album'

class ListAll
  def initialize(main)
    @main = main
  end

  def list_all_games
    if @main.items.empty?
      puts 'No games found.'
    else
      puts 'List of all games:'
      @main.items.each do |item|
        if item.is_a?(Game)
          puts "ID: #{item.id}, Multiplayer: #{item.multiplayer}, Last played at: #{item.last_played_at}"
        end
      end
    end
  end

  def list_all_books
    if @main.items.empty?
      puts 'No books found.'
    else
      puts 'List of all books:'
      @main.items.each do |item|
        puts "ID: #{item.id}, Publisher: #{item.publisher}, Cover State: #{item.cover_state}" if item.is_a?(Book)
      end
    end
  end

  def list_all_albums
    if @main.items.empty?
      puts 'No albums found.'
    else
      puts 'List of all albums:'
      @main.items.each do |item|
        next unless item.is_a?(MusicAlbum)

        output = "ID: #{item.id}, Publisher: #{item.publisher},"
        output += "  Title: #{item.title}, Artist: #{item.artist},"
        output += " On Spotify: #{item.on_spotify}"
        puts output
      end
    end
  end

  def list_all_labels
    if @main.labels.empty?
      puts 'No labels found.'
    else
      puts 'List of all labels:'
      @main.labels.each do |label|
        puts "Name: #{label.name}, Color: #{label.color}"
      end
    end
  end

  def list_all_authors
    if @main.authors.empty?
      puts 'No authors found.'
    else
      puts 'List of all authors:'
      @main.authors.each do |author|
        puts "First name: #{author.first_name}, Last_name: #{author.last_name}"
      end
    end
  end

  def list_all_genres
    if @main.genres.empty?
      puts 'No genres found.'
    else
      puts 'List of all genres:'
      @main.genres.each do |_genre|
        puts "Id: #{genre.id}, Name: #{genre.name}"
      end
    end
  end
end
