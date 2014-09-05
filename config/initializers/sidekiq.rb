ENV['REDIS_URL'] = ENV['REDISTOGO_URL'] if Rails.env == "production"

Sidekiq.configure_server do |config|
    config.redis = { :url => ENV['REDIS_URL'], :namespace => 'sensei' }
end

Sidekiq.configure_client do |config|
    config.redis = { :url => ENV['REDIS_URL'], :namespace => 'sensei' }
end
