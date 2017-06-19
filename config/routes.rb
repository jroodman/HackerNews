Rails.application.routes.draw do

  root to: 'home#index'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  resources :users, only: [:new, :create, :edit, :update]
  resources :links, only: [:new, :create]
  
end
