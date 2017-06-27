Rails.application.routes.draw do

  root to: 'home#index'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  resources :users, only: [:new, :create, :edit, :update]
  resources :links, only: [:new, :create] do
    member do
      post :create_link_comment, controller: :comments, as: :create_comment_for
    end
  end
  resources :comments, only: [:index, :new, :destroy] do
    member do
      post :create_child, controller: :comments
    end
  end
  resources :votes, only: [:create, :destroy]

end
