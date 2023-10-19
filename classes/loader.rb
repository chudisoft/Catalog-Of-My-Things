class Loader
  def load_authors
    return unless File.exist?('json_data/authors.json')

    authors_json = JSON.parse(File.read('json_data/authors.json'))
    authors_json.each do |author_data|
      id = author_data['id']
      first_name = author_data['first_name']
      last_name = author_data['last_name']
      author = Author.new(first_name, last_name, id: id)
      main.instance_variable_get(:@authors) << author
    end
  end

  def load_games
    return unless File.exist?('json_data/games.json')

    games_json = JSON.parse(File.read('json_data/games.json'))
    games_json.each do |game_data|
      id = game_data['id']
      publish_date = Date.parse(book_data['publish_date'])
      multiplayer = book_data['multiplayer']
      last_played_at = book_data['last_played_at']
      game = Game.new(publish_date, multiplayer, last_played_at, id: id)
      main.instance_variable_get(:@items) << game
    end
  end
end
