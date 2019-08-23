Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]  
  resources :users, only: [:new, :create, :show]
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:new, :index]
end
