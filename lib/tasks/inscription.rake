
namespace :simplon do

  desc 'Create a user'
  task :create_user => [:environment] do
    email = ENV['email']
    puts "create user #{email}"
    user = User.find_by(email: email)
    unless user
      User.inscription(email)
    end
    puts "End of creation"
  end

  desc 'Create users'
  task :create_users => [:environment] do
    file = ENV['file']
    puts "create users with #{file}"
    File.open(file, 'r') do |f|
      email = f.read.chomp
      user = User.find_by(email: email)
      unless user
        User.inscription(email)
      end
    end

    puts "End of creation"
  end
end

