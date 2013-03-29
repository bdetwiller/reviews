
require 'debugger'
class Chef
  attr_accessor :fname, :lname, :mentor
  attr_reader :id

  def initialize(attributes)
  	@id = attributes['id'] || nil
    @fname = attributes['fname']
    @lname = attributes['lname']
    @mentor = attributes['mentor'] || 0
	end

	def self.find_by_id(id)
		query = <<-SQL
			SELECT *
				FROM chefs
				WHERE id = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, id)[0]
		Chef.new(attributes)
	end

	def self.find_by_name(fname, lname)
		query = <<-SQL
			SELECT *
			FROM chefs
			WHERE fname = ? AND lname = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, fname, lname)[0]
		Chef.new(attributes)
	end

	def proteges
		query = <<-SQL
			SELECT *
			FROM chefs
			WHERE mentor = ?
		SQL

		chefs = RestaurantDatabase.instance.execute(query, self.id)
		chefs.map { |attributes| Chef.new(attributes) }
	end

	def num_proteges
		query = <<-SQL
			SELECT COUNT(*) as num_of_proteges
			FROM chefs
			WHERE mentor = ?
		SQL

		RestaurantDatabase.instance.execute(query, self.id)[0]['num_of_proteges']
	end

	def reviews
		query = <<-SQL
			SELECT reviews.*
			FROM reviews JOIN chef_tenure 
			ON reviews.restaurant_id = chef_tenure.restaurant_id
			WHERE chef_id = ? AND review_date BETWEEN start_date AND end_date
		SQL

		reviews = RestaurantDatabase.instance.execute(query, self.id)
		reviews.map { |attributes| Review.new(attributes)}
	end

	def co_workers
		query = <<-SQL
		SELECT chefs.*
			FROM chefs 
			JOIN chef_tenure AS coworker_t
			ON chefs.id = coworker_t.chef_id
			JOIN chef_tenure AS subject_t
			ON coworker_t.restaurant_id = subject_t.restaurant_id
			WHERE coworker_t.chef_id != subject_t.chef_id
			AND coworker_t.start_date < subject_t.end_date 
			AND subject_t.start_date < coworker_t.end_date
			AND subject_t.chef_id = ?
		SQL

		chefs = RestaurantDatabase.instance.execute(query, self.id)
		chefs.map { |attributes| Chef.new(attributes)}
	end

end
