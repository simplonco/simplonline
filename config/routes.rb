Rails.application.routes.draw do

  get '/', to: 'static#dashboard'

  get '/welcome', to: 'static#welcome'
  get '/contact', to: 'static#contact'
  get '/legal', to: 'static#legal'

  root 'static#dashboard'

  resource :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show]
  resource :reset_password

  resources :lessons do
    resources :chapters
    resources :qcms do
      resources :questions do
        resources :answers
      end
    end
    resources :exercices
  end

  resources :exercices do
    resources :essais
  end

  resources :messages do
    resources :comments
  end

  resources :tags

  resources :definitions

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
