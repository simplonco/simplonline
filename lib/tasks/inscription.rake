
namespace :simplon do

    desc 'Create a user'
    task :create_users => [:environment] do
      file = ENV['file']
      puts "create users with: #{file}"

      File.open(file) do |f|
        User.inscription(f.read)
      end

      puts "End of creation"
    end
end

