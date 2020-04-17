require_relative '../config/environment'
ActiveRecord::Base.logger = nil



puts "Welcome to your Beer Search!
What's your full name?"

def username
  username = gets.chomp
end

session_user = find_user

age_limiter(session_user)
