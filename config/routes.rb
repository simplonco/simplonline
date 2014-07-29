Rails.application.routes.draw do
  root 'essais#index'
  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
