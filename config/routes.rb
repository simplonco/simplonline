Rails.application.routes.draw do

  root 'essais#accueil'
  get 'essais/accueil'

  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update]
  resources :qcms

  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
