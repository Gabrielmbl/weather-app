Rails.application.routes.draw do
  resources :locations
  resources :users
  root 'users#index'
end
