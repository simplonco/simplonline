Rails.application.routes.draw do

  root 'static#welcome'
  get '/', to: 'static#welcome'

  resource :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show]

  resources :qcms do
    resources :questions
  end

  resources :lessons

  get 'essais/accueil'

  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
