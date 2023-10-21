require 'date'
require_relative '../classes/item'
require_relative '../classes/book'

describe Book do
  let(:book_good) { Book.new(Date.new(2010, 1, 1), 'Pulisher 1', 'good', id: 1) }
  let(:book_bad) { Book.new(Date.new(2010, 1, 1), 'Pulisher 2', 'bad', id: 2) }

  it 'returns true for a book with a good cover and an old publication date' do
    expect(book_good.can_be_archived?).to be true
  end

  it 'returns true for a book with a bad cover and an old publication date' do
    expect(book_bad.can_be_archived?).to be true
  end

  it 'returns false for a book with a good cover and a recent publication date' do
    book_recent = Book.new(Date.new(2021, 1, 1), 'Pulisher 2', 'good')
    expect(book_recent.can_be_archived?).to be false
  end

  it 'returns false for a book with a bad cover and a recent publication date' do
    book_recent_bad = Book.new(Date.new(2022, 1, 1), 'Pulisher 2', 'bad')
    expect(book_recent_bad.can_be_archived?).to be false
  end
end
