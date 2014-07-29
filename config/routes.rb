Rails.application.routes.draw do
  get 'exercices/new'

  get 'exercices/create'

  get 'exercices/index'

  get 'exercices/show'

  get 'exercices/edit'

  get 'exercices/update'

  root 'essais#index'
  resources :exercices do
    resources :essais
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
