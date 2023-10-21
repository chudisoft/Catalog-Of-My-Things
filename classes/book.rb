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
      'id' => @id,
      'title' => @title,
      'publish_date' => @publish_date,
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'label' => @label.map(&:to_json),
      'archived' => @archived
    }
  end
end

def to_json(*_args)
  {
    'id' => @id,
    'publish_date' => @publish_date,
    'publisher' => @publisher,
    'cover_state' => @cover_state,
    'label' => @label.map(&:to_json), # Ensure label is converted to JSON as well
    'author' => @author.map(&:to_json) # Ensure author is converted to JSON as well
  }.to_json
end
