class GenreLoader
  def self.load_genres(main)
    return unless File.exist?('json_data/genres.json')

    genres_json = JSON.parse(File.read('json_data/genres.json'))
    genres_json.each do |genre_data|
      id = genre_data['id']
      name = genre_data['name']
      genre = Genre.new(name, id: id)
      main.instance_variable_get(:@items) << genre
    end
  end
end
