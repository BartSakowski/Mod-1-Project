
# def username
#   username = gets.chomp
# end

# def session_user
#   User.find_or_create_by(name: username)
# end

# def beer_list(session_user)
#   beer_list_array = User_Beer.where("user_id == #{session_user.id}")
#   beer_id_array = []
#   beer_list_array.each do |beers|
#   beer_id_array << beers.beer_id
#   end
#   beer_instances = Beer.find(beer_id_array)
#   beer_instances.each do |beer|
#     puts "Beer Name: #{beer.name}"
#     puts "Beer ID: #{beer.id}"
#   end
# end

