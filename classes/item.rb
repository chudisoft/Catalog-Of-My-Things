class Item
  attr_reader :id, :genre, :author, :source, :label
  attr_writer :publish_date

  def initialize(_id, publish_date)
    @id = rand(1..200)
    @genre = []
    @author = []
    @source = []
    @label = []
    @publish_date = publish_date
    @archived = false
  end

  def add_genre(genre)
    @genre << genre unless genre?.include(genre)
  end

  def add_author(author)
    @author << author unless author?.include(author)
  end

  def add_label(label)
    @label << label unless label?.include(label)
  end

  def add_source(source)
    @source << source unless source?.include(source)
  end

  def move_to_archive
    @archived = true
  end

  private

  def can_be_archived
    # Calculate the current year
    current_year = Time.now.year

    # Check if the publish date is older than 10 years
    publish_year = @publish_date.year
    return current_year - publish_year > 10
  end
end
