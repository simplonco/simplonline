
namespace :simplon do

    desc 'Create a user'
    task :create_users => [:environment] do
      file = ENV['file']
      puts "create users with #{file}"

      File.open(file) do |f|
        email = f.read.chomp
        user = User.find_by(email: email)
        if user
          User.reset_password(email)
        else
          User.inscription(f.read)
        end
      end

      puts "End of creation"
    end
end

