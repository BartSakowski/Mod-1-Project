class Beer < ActiveRecord::Base
  has_many :user_beers 
  has_many :users, through: :user_beers

def beer_name(beer_name)
found_beer = Beer.find_by(name: beer_name)
puts found_beer.name
puts found_beer.description
end

end