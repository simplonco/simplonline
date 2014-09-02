Sidekiq.configure_server do |config|
    config.redis = { :url => 'redis://redistogo:811942f2ce762ccc3225e3b85cc5b27a@jack.redistogo.com:10144/', :namespace => 'sensei' }
end

Sidekiq.configure_client do |config|
    config.redis = { :url => 'redis://redistogo:811942f2ce762ccc3225e3b85cc5b27a@jack.redistogo.com:10144/', :namespace => 'sensei' }
end
