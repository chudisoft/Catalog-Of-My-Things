class MusicAlbumLoader
  def self.load_music_albums(main)
    return unless File.exist?('json_data/music_album.json')

    music_album_json = JSON.parse(File.read('json_data/music_album.json'))
    music_album_json.each do |music_album_data|
      title = music_album_data['title']
      artist = music_album_data['artist']
      on_spotify = music_album_data['on_spotify']
      genre = music_album_data['genre']
      music_album = MusicAlbum.new(title, artist, on_spotify, genre)
      main.instance_variable_get(:@music_album) << music_album
    end
  end
end
