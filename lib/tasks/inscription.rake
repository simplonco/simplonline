
namespace :simplon do

    desc 'Create a user'
    task :create_users => [:environment] do
      file = ENV['file']
      puts "create users with #{file}"
      File.open(file, 'r') do |f|
        email = f.read.chomp
        user = User.find_by(email: email)
        puts "existing user: #{user.inspect}"
        unless user
          puts "inscription"
          User.inscription(email)
        end
      end

      puts "End of creation"
    end
end

