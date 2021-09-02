Rails.application.routes.draw do
  # get 'comments/create'
  # get 'comments/destroy'
  root 'home#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get    '/about',   to: 'static_pages#about'
  resources :users
  resources :animals
  resources :comments, only: %i[create destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end