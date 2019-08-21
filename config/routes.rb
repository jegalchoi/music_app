Rails.application.routes.draw do
  resources :session, only: [:new, :create, :destroy]  
  resources :users, only: [:new, :create, :show]
end
