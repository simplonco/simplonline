
namespace :simplon do

  def inscription(email, method)
    puts "create user #{email}"
    user = User.find_by(email: email)
    unless user
      User.send(method, email)
    end
    puts "End of creation"
  end

  def parse_data_for(inscription_method)
    file = ENV['file']
    email = ENV['email']
    emails = []

    if file
      emails = File.open(file, 'r').readlines.map(&:chomp)
    elsif
      emails = [ENV['email']]
    end

    emails.each do |mail|
      inscription(mail, inscription_method)
    end
  end

  desc 'Create a remote student'
  task :create_remote => [:environment] do
    parse_data_for(:inscription)
  end

  desc 'Create a local student'
  task :create_local => [:environment] do
     parse_data_for(:inscription_local)
  end

  desc 'Create a staff urse'
  task :create_staff => [:environment] do
     parse_data_for(:inscription_staff)
  end
end

