Rails.application.routes.draw do
  root 'essais#index'
  resources :essais
end
