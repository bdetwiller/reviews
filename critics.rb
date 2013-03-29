class Critic
  attr_accessor :screen_name
  attr_reader :id

  def initialize(attributes)
  	@id = attributes['id'] || nil
    @screen_name = attributes['screen_name']
	end

	def self.find_by_id(id)
		query = <<-SQL
			SELECT *
				FROM critics
				WHERE id = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, id)[0]
		Critic.new(attributes)
	end

	def unreviewed_restaurants
		query = <<-SQL
			SELECT restaurants.*
			FROM restaurants
			WHERE restaurants.id NOT IN 
				(SELECT restaurants.id
				FROM restaurants JOIN reviews ON restaurants.id = restaurant_id
				WHERE critic_id = ?
				GROUP BY restaurants.id)
		SQL

		restaurants = RestaurantDatabase.instance.execute(query, self.id)
		restaurants.map { |attributes| Restaurant.new(attributes) }
	end

end