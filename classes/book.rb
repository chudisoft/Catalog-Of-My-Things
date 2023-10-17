class Book < Item
  attr_reader :title, :author, :publication_year

  def initialize(id, publish_date, title, author, publication_year)
    super(id, publish_date)
    @title = title
    @author = author
    @publication_year = publication_year
  end
end
