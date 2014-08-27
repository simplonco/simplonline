Rails.application.routes.draw do

  get '/', to: 'users#show'

  get '/welcome', to: 'static#welcome'

  root 'users#show'

  resource :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show]

  resources :qcms do
    resources :questions do
      resources :answers
    end
  end

  resources :lessons

  get 'essais/accueil'

  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
