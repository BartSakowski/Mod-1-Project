
# def username
#   username = gets.chomp
# end

def find_user # finds the user
  User.find_or_create_by(name: username)
end

def beer_list(session_user) # shows user's beer list
  beer_list_array = User_Beer.where("user_id == #{session_user.id}")
  beer_id_array = []
  beer_list_array.each do |beers|
  beer_id_array << beers.beer_id
  end
  beer_instances = Beer.find(beer_id_array)
  beer_instances.each do |beer|
    puts "Beer Name: #{beer.name}"
    puts "Beer ID: #{beer.id}"
    puts "Beer ABV: #{beer.abv}"
    puts "Beer Description: #{beer.description}"
  end
end

def enter_to_continue # puts the below string, used after a menu option
  puts "<<<press 'enter' to continue>>>"
  user_input = gets.chomp
end

def what_else(session_user) # gets user back to main menu
  puts "\e[H\e[2J"
  puts "What else would you like to do?"
  menu_prompt(session_user)
end