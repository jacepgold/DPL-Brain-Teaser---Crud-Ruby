require 'httparty'
require 'colorize'
require 'pry'

# Constant - should not change
BASE_URL = "http://json-server.devpointlabs.com/api/v1"
@users = HTTParty.get("#{BASE_URL}/users").parsed_response

# def set_users
#   @users = HTTParty.get("#{BASE_URL}/users").parsed_response
# end


# implement a menu that is in a loop until the user quits
# 1. all users
# 2. single user
# 3. add user
# 4. update user
# 5. quit

def get_single(id)
  user = @users = HTTParty.get("#{BASE_URL}/users/#{id}").parsed_response
end


def delete_request(id)
  HTTParty.delete("#{BASE_URL}/users/#{id}")
  puts "User Deleted"
end

def view_all
  @users.each do |user|
    puts "\n----------------------------------------------"
    puts "User ID:      #{user['id']}".yellow
    puts "First Name:   #{user['first_name']}".green
    puts "Last Name:    #{user['last_name']}".green
    puts "Phone:        #{user['phone']}".green
    puts '----------------------------------------------'
  end
end


def view_single
  view_all
  puts "Who would you like to see?"
  print '> '
  choice = gets.strip
  choice = choice.to_i

  user = get_single(choice)

  puts '----------------------------------------------'
  puts "\nUser ID:      #{user['id']}".yellow
  puts "First Name:   #{user['first_name']}".green
  puts "Last Name:    #{user['last_name']}".green
  puts "Phone:        #{user['phone']}".green
  puts '----------------------------------------------\n\ '
end


def add_user
  puts '--- Create New User ---'
  print 'First Name: '
  first_name = gets.strip
  print "\nLast Name: "
  last_name = gets.strip
  print "\nPhone: "
  phone = gets.strip

  puts "Creating user...".yellow
  
  params = Utils.user_params

  puts "\n\nMake call to server with a put request\n\n".red
end


def update_user
  puts 'What user ID would you like to Update?'
  view_all
  puts 'Choose a User ID to Update...'
  print '> '
  choice = gets.strip
  choice = choice.to_i

  puts "\n\nMake call to server to update user\n\n".red
end


def delete_user
  puts 'What user ID would you like to Delete?'.green
  view_all
  puts 'Choose a User ID to Delete...'.red
  print '> '
  choice = gets.strip
  choice = choice.to_i

  delete_request(choice)
end


def menu
  puts '---- API Users Crud Ruby ----'
  puts "\n1. View Users".green
  puts '2. Single User'.green
  puts '3. Create User - Working On'.green
  puts '4. Update User - To Do'.yellow
  puts '5. Delete User'.red
  puts '6. Quit'
  print "\n> "
  choice = gets.strip

  case choice
    when '1'
      view_all
      menu
    when '2'
      view_single
      menu
    when '3'
      add_user
      menu
    when '4'
      update_user
      menu
    when '5'
      delete_user
      menu
    when '6'
      puts "\nThanks for using this program!\n\n"
      exit
    else
      puts 'Invalid input. Please try again.'
      menu
  end

end

# Call the menu function to start the program
menu