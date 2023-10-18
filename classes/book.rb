require 'json'

class Book < Item
  attr_reader :publisher, :cover_state

  def initialize(publish_date, publisher, cover_state, id: 0)
    super(publish_date, id: id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    parent_result = super
    # Check if the publication date is older than 10 years
    publish_year = @publish_date.year
    current_year = Time.now.year

    parent_result || (@cover_state == 'bad' && (current_year - publish_year > 10))
  end

  def to_json(*_args)
    {
      id: @id,
      genre: @genre,
      author: @author,
      source: @source,
      label: @label,
      publish_date: @publish_date,
      archived: @archived,
      publisher: @publisher,
      cover_state: @cover_state
    }.to_json
  end
end
