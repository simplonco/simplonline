Rails.application.routes.draw do

  get '/', to: 'static#dashboard'

  get '/welcome', to: 'static#welcome'
  get '/contact', to: 'static#contact'
  post '/contact', to: 'static#send_contact'
  get '/about', to: 'static#about'
  get '/legal', to: 'static#legal'

  get '/chapters', to: 'chapters#index'

  root 'static#dashboard'

  resource :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show]
  resource :reset_password

  resources :lessons do
    resources :chapters do
      resources :submissions do
        resource :validation
      end
    end
    resources :qcms do
      resources :questions do
        resources :answers
        get 'result'
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
