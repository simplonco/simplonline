Rails.application.routes.draw do
  root 'essais#accueil'
  get 'essais/accueil'

  get '/auth/:provider/callback' => 'sessions#create'
  get 'deconnexion' => 'sessions#destroy'

  resources :users, only: [:edit, :update]

  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
