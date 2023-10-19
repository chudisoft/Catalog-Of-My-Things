class BookLoader
  def self.load_books(main)
    return unless File.exist?('json_data/books.json')

    books_json = JSON.parse(File.read('json_data/books.json'))
    books_json.each do |book_data|
      id = book_data['id']
      publish_date = Date.parse(book_data['publish_date'])
      publisher = book_data['publisher']
      cover_state = book_data['cover_state']
      book = Book.new(publish_date, publisher, cover_state, id: id)
      main.instance_variable_get(:@items) << book
    end
  end
end
