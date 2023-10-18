require_relative '../classes/genre'
require_relative '../classes/item'

describe Genre do
  let(:genre_name) { 'Mystery' }
  let(:genre) { Genre.new(1, genre_name) }

  it 'has a name' do
    expect(genre.name).to eq(genre_name)
  end

  it 'initializes with an empty items collection' do
    expect(genre.items).to be_an(Array)
    expect(genre.items).to be_empty
  end

  it 'can add an item to its collection' do
    item = double('item')
    expect(item).to receive(:genre=).with(genre)
    genre.add_item(item)
    expect(genre.items).to include(item)
  end

  it 'sets the genre association for the added item' do
    item = double('item')
    expect(item).to receive(:genre=).with(genre)
    genre.add_item(item)
  end
end
