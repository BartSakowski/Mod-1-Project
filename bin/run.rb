require_relative '../config/environment'
ActiveRecord::Base.logger = nil

#find or create user 
#display menu

#1. Search beers by beer name
#2. Search beers by ABV
#3. Add beer(s) by beer id
#5. Display your list of beers
#6. Add a food pairing for a beer in your list. 

puts "Hi, what's your full name?"
username = gets.chomp 

session_user = User.find_or_create_by(name: username)

puts "Welcome, #{session_user.name}!"

def menu_prompt

  puts "---MENU---
  #1. Search beers by beer name
  #2. Search beers by ABV
  #3. Add beer(s) by beer id
  #4. Display your list of beers
  #5. Delete a beer from your list.
  #6. Add rating to a beer.
  #7. Add a personal pairing to a beer." 

  user_input= gets.chomp

  if user_input == "1"
    #Search beers by beer name... Returns beer description, ABV, and food pairing
    puts "Please enter a beer name"
    user_input = gets.chomp
    result = Beer.find_by(name: user_input)
    puts "ID #{result.id}"
    puts "Name: #{result.name}"
    puts "Description: #{result.description}"
    puts "ABV: #{result.abv}"
    puts "Food Pairing: #{result.food_pairing}"

    puts "What else would you like to do?"
      menu_prompt

  elsif user_input == "2" 
    #Search beers by ABV. Returns beer description, ABV, and food pairing
    puts "Enter the ABV of the beer(s) you want"
    user_input_chomp = gets.chomp
    user_input = user_input_chomp.to_f 
    result = Beer.where("abv == #{user_input}")
    result.each do |beer|
    puts "ID #{beer.id}"
    puts "Name: #{beer.name}"
    puts "Description: #{beer.description}"
    puts "ABV: #{beer.abv}"
    puts "Food Pairing: #{beer.food_pairing}"
    end

    puts "What else would you like to do?"
      menu_prompt

  elsif user_input == "3" 
    #Add beer(s) by beer id.
    puts "Please type in the beer id or beer ids seperated by commas"
    user_input_chomp = gets.chomp
    user_input_array = user_input_chomp.split(', ')
    user_input_int_array = user_input_array.map { |element| element.to_i }
    user_input_int_array.each do |beer_id|
      User_Beer.create(user_id: session_user.id, beer_id: beer_id)
    end

    puts "What else would you like to do?"
      menu_prompt

  elsif user_input == "4"
    puts "Here is your beer list:"
    beer_list_array = User_Beer.where("user_id == #{session_user.id}")
    beer_id_array = []
    beer_list_array.each do |beers|
    beer_id_array << beers.beer_id
    end
    beer_instances = Beer.find(beer_id_array)
    beer_instances.each do |beer|
      puts "Beer Name: #{beer.name}"
      puts "Beer ID: #{beer.id}"
    end
    # beer_id_array.each do |beer_id|
    # puts Beer.find(beer_id)
    #Beer.where("id == beer_id")

    puts "What else would you like to do?"
      menu_prompt


  elsif user_input == "5" 
  #5. Delete a beer from your list" 
  puts "Get rid of a beer from your list! Type in the beer id(s) you want to delete"
  user_input_chomp = gets.chomp
  user_input = user_input_chomp.to_i
  User_Beer.where("beer_id == #{user_input}").destroy_all
  puts "Here is your updated beer list:"
  #code from number 4 on menu
  beer_list_array = User_Beer.where("user_id == #{session_user.id}")
    beer_id_array = []
    beer_list_array.each do |beers|
    beer_id_array << beers.beer_id
    end
    beer_instances = Beer.find(beer_id_array)
    beer_instances.each do |beer|
      puts "Beer Name: #{beer.name}"
      puts "Beer ID: #{beer.id}"
    end

    puts "What else would you like to do?"
      menu_prompt

  elsif user_input == "6"
    puts "Enter the id of the beer you'd like to rate" # followed by it's rating seperated by a ': '""
    # puts "For example '7: 10'"
    user_input_chomp = gets.chomp
    user_input_beer_id = user_input_chomp.to_i
    puts "Great! Now rate it on a scale of 1-10"
    user_rating_chomp = gets.chomp
    user_rating = user_rating_chomp.to_i
    choice_beer = User_Beer.where(user_id: session_user.id, beer_id: user_input_beer_id)
    choice_beer.update(rating: user_rating)
    puts "Awesome!"
    puts "What else would you like to do?"
      menu_prompt

  elsif user_input == "7"
    puts "Enter the id of the beer for which you'd like to add a pairing"
    user_input_chomp = gets.chomp
    user_input_personal_pairing = user_input_chomp.to_i
    puts "Great! What do you like to pair with that beer?"
      user_pairing_chomp = gets.chomp
      pairing_beer = User_Beer.where(user_id: session_user.id, beer_id: user_input_personal_pairing)
      pairing_beer.update(personal_pairing: user_pairing_chomp)
    puts "MMMM!! That looks like a good combo! :P"
    puts "What else would you like to do?"
      menu_prompt

  else
    puts "Incorrect menu option. Please enter valid menu option"
    menu_prompt
  end  
end

menu_prompt

# puts use_test.name

# puts "find by abv"
# abv_input = gets.chomp

# abv_beer = Beer.find_by(abv: abv_input)

# puts abv_beer.name


# beer_name = gets.chomp
# found_beer = Beer.find_by(name: beer_name)
# puts found_beer.name
# puts found_beer.description

