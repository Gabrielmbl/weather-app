Rails.application.routes.draw do
  resources :locations
  resources :users
  root 'locations#index'
end
