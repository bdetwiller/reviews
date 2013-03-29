class Tenure
  attr_accessor :restaurant_id, :start_date, :end_date, :head_chef, :chef_id
  attr_reader :id

  def initialize(attributes)
  	@id = attributes['id'] || nil
    @restaurant_id = attributes['restaurant_id']
    @start_date = attributes['start_date']
    @end_date = attributes['end_date']
    @head_chef = attributes['head_chef']
    @chef_id = attributes['chef_id']
	end

	def self.find_by_chef(id)
		query = <<-SQL
			SELECT *
				FROM chef_tenure
				WHERE chef_id = ?
		SQL

		attributes = RestaurantDatabase.instance.execute(query, id)[0]
		Tenure.new(attributes)
	end
end