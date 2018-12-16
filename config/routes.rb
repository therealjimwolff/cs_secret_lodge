Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
# Static pages
  get '/home', to: 'static_pages#home'
# Users
  resources :users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
# Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
# Posts
  resources :posts, only: [:index, :new, :create, :destroy]

end