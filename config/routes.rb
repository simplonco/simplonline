Rails.application.routes.draw do
  root 'essais#index'
  
  get '/auth/:provider/callback' => 'sessions#create'
  get 'deconnexion' => 'sessions#destroy'
  get 'utilisateurs/edit' => 'utilisateurs#edit', as: :edit_utilisateur
  patch 'utilisateurs/edit' => 'utilisateurs#update', as: :utilisateur

  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
