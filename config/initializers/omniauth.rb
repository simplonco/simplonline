Rails.application.config.middleware.use OmniAuth::Builder do
  provider :browser_id
end
