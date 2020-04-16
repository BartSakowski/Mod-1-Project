def age_limiter(session_user)
  puts "Please enter your age"
  user_input_chomp = gets.chomp
  user_input = user_input_chomp.to_f 
  if user_input > 20
    puts 'Great, enjoy responsibly!'
    puts "Welcome, #{session_user.name}!"
    menu_prompt(session_user)
  else
    puts "Come back when you are over 21!"
  end
end