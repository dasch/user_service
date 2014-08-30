Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :suspensions, only: [:create]
end
