require 'date'
require_relative '../classes/music_album'

describe MusicAlbum do
  let(:title) { 'Album Title' }
  let(:artist) { 'Artist Name' }
  let(:release_date) { Date.new(2010, 1, 1) }
  let(:genre) { double('genre') }
  let(:music_album) { MusicAlbum.new(title, artist, release_date, genre) }

  it 'inherits from Item' do
    expect(MusicAlbum.superclass).to eq(Item)
  end

  it 'initializes with title, artist, and release date' do
    expect(music_album.title).to eq(title)
    expect(music_album.artist).to eq(artist)
    expect(music_album.publish_date).to eq(release_date)
  end

  it 'is not initially on Spotify' do
    expect(music_album.on_spotify?).to be(false)
  end

  it 'can be archived if older than 10 years and on Spotify' do
    music_album.instance_variable_set(:@on_spotify, true)
    expect(music_album.send(:can_be_archived?)).to be(true)
  end

  it 'cannot be archived if not on Spotify' do
    expect(music_album.send(:can_be_archived?)).to be(false)
  end
end
