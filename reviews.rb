class Review
  attr_accessor :critic_id, :restaurant_id, :text_review, :score, :review_date
  attr_reader :id

  def initialize(attributes)
  	@id = attributes['id'] || nil
    @critic_id = attributes['critic_id']
    @restaurant_id = attributes['restaurant_id']
    @text_review = attributes['text_review']
    @score = attributes['score']
    @review_date = attributes['review_date']
	end

	def self.find_by_id(id)
		query = <<-SQL
			SELECT *
				FROM reviews
				WHERE id = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, id)[0]
		Review.new(attributes)
	end

end