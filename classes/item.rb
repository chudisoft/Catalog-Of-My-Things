require 'json'

class Item
  attr_reader :id, :genre, :author, :source, :label
  attr_writer :publish_date

  def initialize(publish_date, id: 0)
    @id = id <= 0 ? rand(1..200) : id
    @genre = []
    @author = []
    @source = []
    @label = []
    @publish_date = publish_date
    @archived = false
  end

  def add_genre(genre)
    @genre << genre unless genre.include?(genre)
  end

  def add_author(author)
    @author << author unless @author.include?(author)
  end

  def add_label(label)
    @label << label unless @label.include?(label)
  end

  def add_source(source)
    @source << source unless @source.include?(source)
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def to_json(*_args)
    {
      'id' => @id,
      'genre' => @genre,
      'author' => @author,
      'source' => @source,
      'label' => @label,
      'publish_date' => @publish_date,
      'archived' => @archived
    }
  end

  private

  def can_be_archived?
    # Calculate the current year
    current_year = Time.now.year

    # Check if the publish date is older than 10 years
    publish_year = @publish_date.year
    current_year - publish_year > 10
  end
end
