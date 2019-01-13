Rails.application.routes.draw do
  
  get 'sessions/new'

  root 'sessions#new'
  get '/help', to:"home#help"
  get '/about', to:"home#about"
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :microposts,          only: [:create, :destroy]
end
