require_relative '../config/environment'
ActiveRecord::Base.logger = nil



puts "Welcome to your Beer Search!
What's your full name?"

def username
  username = gets.chomp
end

session_user = find_user


age_limiter(session_user)

# session_user = User.find_or_create_by(name: username)
# puts "\e[H\e[2J"
# puts "Welcome, #{session_user.name}!"

# # binding.pry   
# menu_prompt(session_user)

# puts use_test.name

# puts "find by abv"
# abv_input = gets.chomp

# abv_beer = Beer.find_by(abv: abv_input)

# puts abv_beer.name


# beer_name = gets.chomp
# found_beer = Beer.find_by(name: beer_name)
# puts found_beer.name
# puts found_beer.description