require 'singleton'
require 'sqlite3'
require_relative 'chefs'
require_relative 'restaurants'
require_relative 'critics'
require_relative 'reviews'
require_relative 'tenure'

class RestaurantDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("RestaurantDatabase.db")
    self.results_as_hash = true
    self.type_translation = true
  end
end

p Restaurant.highly_reviewed_restaurants(1)
#p Chef.find_by_id(3).co_workers
#p Tenure.find_by_chef(1)
#p Chef.find_by_id(1).reviews
#p Restaurant.find_by_name("Tacqueria Cancun").reviews
#p Restaurant.find_by_name("Tacqueria Cancun").average_review_score
#p Critic.find_by_id(1)
#p Critic.find_by_id(1).unreviewed_restaurants