# label_spec.rb
require 'rspec'
require_relative '../classes/label'
require_relative '../classes/item'

describe Label do
  let(:label) { Label.new('Sample Label', 'Blue') }
  let(:item) { Item.new(1, Date.new(2020, 1, 1)) }

  it 'initializes with a name and color' do
    expect(label.name).to eq('Sample Label')
    expect(label.color).to eq('Blue')
  end

  it 'adds an item and sets the label property on the item' do
    label.add_item(item)

    expect(label.items).to include(item)
    expect(item.label).to eq(label)
  end
end
