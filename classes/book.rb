class Book < Item
  attr_reader :title, :author, :publication_year

  def initialize(publish_date, title, author, publication_year, id: 0)
    super(publish_date, id)
    @title = title
    @author = author
    @publication_year = publication_year
  end
end
