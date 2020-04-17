def age_limiter(session_user) # prompts user to enter age, runs program if over 21, closes program if under 21
  puts "Please enter your age"
  user_input_chomp = gets.chomp
  user_input = user_input_chomp.to_f 
  if user_input > 20
    # user.age << user_input
    puts "\e[H\e[2J"
    puts "\nGreat, enjoy responsibly!"
    puts "\nWelcome, #{session_user.name}!\n"

    menu_prompt(session_user)
  else
    puts "Come back when you are over 21!"
  end
end