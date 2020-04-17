def menu_prompt(session_user)

  puts   "  \n  ------------–MENU-–––---------
  #1. Search beers by beer name
  #2. Search beers by ABV
  #3. Add beer(s) by beer id
  #4. Display all available beers
  #5. Display your list of beers
  #6. Delete a beer from your list
  #7. Add rating to a beer
  #8. Add a personal pairing to a beer
  #9. Add another user's beers to your list

  <<<type 'exit' to end program>>>" 

  user_input= gets.chomp


  if user_input == "1" # Search beers by beer name... Returns beer description, ABV, and food pairing
    puts "\e[H\e[2J"
    puts "Please enter a beer name"
    user_input = gets.chomp
    result = Beer.find_by(name: user_input)
    puts "\e[H\e[2J"
    puts "Here's the information you were looking for!"
    puts "Name: #{result.name}"
    puts "ID: #{result.id}"
    puts "Description: #{result.description}"
    puts "ABV: #{result.abv}"
    puts "Food Pairing: #{result.food_pairing}"

    enter_to_continue
    what_else(session_user)

  elsif user_input == "2" # Search beers by ABV. Returns beer description, ABV, and food pairing
    puts "\e[H\e[2J"
    puts "Enter the ABV of the beer(s) you want"
    user_input_chomp = gets.chomp
    user_input = user_input_chomp.to_f 
    result = Beer.where("abv == #{user_input}")
    result.each do |beer|
    puts "\e[H\e[2J"
    puts "Here are the beer(s) with #{user_input}% abv:"
    puts "ID: #{beer.id}"
    puts "Name: #{beer.name}"
    puts "Description: #{beer.description}"
    puts "ABV: #{beer.abv}"
    puts "Food Pairing: #{beer.food_pairing}"
    end

    enter_to_continue
    what_else(session_user)

  elsif user_input == "3" # Add beer(s) by beer id.
    puts "\e[H\e[2J" # clears terminal
    puts "Please type in the beer id or beer ids seperated by commas"
    user_input_chomp = gets.chomp
    user_input_array = user_input_chomp.split(', ')
    user_input_int_array = user_input_array.map { |element| element.to_i }
    user_input_int_array.each do |beer_id|
      User_Beer.create(user_id: session_user.id, beer_id: beer_id)
    end
    puts "Here is your updated beer list"
    beer_list(session_user)
    enter_to_continue
    what_else(session_user)

  elsif user_input == "4" # Display all the available beers
    Beer.all.each do |beer|
      puts "Beer Name: #{beer.name}"
      puts "Beer ID: #{beer.id}"
      puts "Beer ABV: #{beer.abv}"
      puts "Beer Description: #{beer.description}"
      puts "Food Pairing: #{beer.food_pairing}"
    end
      enter_to_continue
      what_else(session_user)


  elsif user_input == "5" # Display your beer list
    puts "\e[H\e[2J"
    puts "Here is your beer list:"  
    beer_list(session_user)
    enter_to_continue
    what_else(session_user)


  elsif user_input == "6" # Delete a beer from your list" 
    puts "\e[H\e[2J"
    puts "Get rid of a beer from your list! Type in the beer id(s) you want to delete"
    user_input_chomp = gets.chomp
    user_input = user_input_chomp.to_i
    User_Beer.where("beer_id == #{user_input}").destroy_all
    puts "Here is your updated beer list:"
      beer_list(session_user)
      enter_to_continue
      what_else(session_user)

  elsif user_input == "7" # rate your beer
    puts "\e[H\e[2J"
    puts "Enter the id of the beer you'd like to rate" 
    user_input_chomp = gets.chomp
    user_input_beer_id = user_input_chomp.to_i
    puts "Great! Now rate it on a scale of 1-10"
    user_rating_chomp = gets.chomp
    user_rating = user_rating_chomp.to_i
    choice_beer = User_Beer.where(user_id: session_user.id, beer_id: user_input_beer_id)
    choice_beer_chomp = choice_beer.update(rating: user_rating)
    puts "Awesome! Glad you liked and/or hated that one!"
    enter_to_continue
    what_else(session_user)

  elsif user_input == "8" # add a personal pairing
    puts "\e[H\e[2J"
    puts "Enter the id of the beer for which you'd like to add a pairing"
    user_input_chomp = gets.chomp
    user_input_personal_pairing = user_input_chomp.to_i
    puts "Great! What do you like to pair with that beer?"
      user_pairing_chomp = gets.chomp
      pairing_beer = User_Beer.where(user_id: session_user.id, beer_id: user_input_personal_pairing)
      pairing_beer.update(personal_pairing: user_pairing_chomp)
    puts "MMMM!! That looks like a good combo! :P"
    enter_to_continue
    what_else(session_user)

  elsif user_input == "9" # Merge with another user
    puts "Here are all the users:"
    User.all.each do |user|
     puts user.name
    end
    puts "Who's beer list did you want to merge with yours?"
    user_input = gets.chomp
    name = User.find_by(name: user_input)
    important_id = name.id
    
    User_Beer.all.each do |user_beer_instance|
      if user_beer_instance.user_id == important_id
         User_Beer.create(user_id: session_user.id, beer_id: user_beer_instance.beer_id)
        #  binding.pry
      end
    end

    beer_list(session_user)
    enter_to_continue
    what_else(session_user)

  elsif user_input == "exit" # text after exit
    puts "\e[H\e[2J"
    puts "See you soon!!"

  else # incorrect input prompt
    puts "\e[H\e[2J"
    puts "Incorrect menu option. Please enter valid menu option"
    menu_prompt(session_user)
  end  
end