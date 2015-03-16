namespace :simplon do

  # launch via cron everyday
  # 16 00 * * * cd /path/to/myrailsapp && /path/to/rake RAILS_ENV=production simplon:inactive_users

  desc "Email inactive remote users since one week"
  task :inactive_users => :environment do
    p "Collecting inactive users..."
    one_week = Time.now.weeks_ago(1)
    two_weeks = Time.now.weeks_ago(2)
    users = User.where(["last_active_at > ? and last_active_at < ?", one_week, two_weeks])
    users.each do |user|
      UserMailer.reminder_to_inactive_users(user)
      p "Email sent to #{user}"
    end
    p "#{users.length} emails sent!"
  end
end
