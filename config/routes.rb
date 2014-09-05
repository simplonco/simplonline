Rails.application.routes.draw do

  get '/', to: 'users#show'

  get '/welcome', to: 'static#welcome'
  get '/contact', to: 'static#contact'
  get '/legal', to: 'static#legal'

  root 'users#show'

  resource :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show]

  resources :qcms do
    resources :questions do
      resources :answers
    end
  end

  resources :lessons do
    resources :chapters
  end

  get 'essais/accueil'

  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
