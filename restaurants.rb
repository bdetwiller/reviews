class Restaurant
  attr_accessor :name, :neighborhood, :cusine
  attr_reader :id

  def initialize(attributes)
  	@id = attributes['id'] || nil
    @name = attributes['name']
    @neighborhood = attributes['neighborhood']
    @cusine = attributes['cusine']
	end

	def self.find_by_id(id)
		query = <<-SQL
			SELECT *
				FROM restaurants
				WHERE id = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, id)[0]
		Restaurant.new(attributes)
	end

	def self.find_by_name(name)
		query = <<-SQL
			SELECT *
			FROM restaurants
			WHERE name = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, name)[0]
		Restaurant.new(attributes)
	end

	def self.find_by_neighborhood(neighborhood)
		query = <<-SQL
			SELECT *
			FROM restaurants
			WHERE neighborhood = ?
		SQL

		restaurants = RestaurantDatabase.instance.execute(query, neighborhood)
		restaurants.map { |attributes| Restaurant.new(attributes)}
	end

	def self.find_by_cusine(cusine)
		query = <<-SQL
			SELECT *
			FROM restaurants
			WHERE cusine = ?
		SQL

		restaurants = RestaurantDatabase.instance.execute(query, cusine)
		restaurants.map { |attributes| Restaurant.new(attributes)}
	end

	def self.top_restaurants(num)                 
		query = <<-SQL
			SELECT restaurants.*, AVG(score)
			FROM restaurants JOIN reviews 
			ON restaurants.id = reviews.restaurant_id
			GROUP BY restaurants.id
			ORDER BY AVG(score) DESC
			LIMIT ?
		SQL

		restaurants = RestaurantDatabase.instance.execute(query, num)
		restaurants.map { |attributes| Restaurant.new(attributes)}
	end

	def self.highly_reviewed_restaurants(min_review)
		query = <<-SQL
			SELECT restaurants.*
			FROM restaurants JOIN reviews 
			ON restaurants.id = reviews.restaurant_id
			GROUP BY reviews.restaurant_id 
			HAVING COUNT(*) >= ?
		SQL

		restaurants = RestaurantDatabase.instance.execute(query, min_review)
		restaurants.map { |attributes| Restaurant.new(attributes)}
	end

	def reviews
		query = <<-SQL
			SELECT *
			FROM reviews
			WHERE restaurant_id = ?
		SQL

		reviews = RestaurantDatabase.instance.execute(query, self.id)
		reviews.map { |attributes| Review.new(attributes)}
	end

	def average_review_score
		query = <<-SQL
			SELECT AVG(score) as avg_score
			FROM reviews
			WHERE restaurant_id = ?
		SQL

		RestaurantDatabase.instance.execute(query, self.id)[0]['avg_score']
	end


end