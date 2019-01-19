Rails.application.routes.draw do
  
  root 'sessions#new'
  #get 'sessions/new'
  
 
  get '/upload', to:"home#upload"
  #get '/help', to:"home#help"
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
   member do
    get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :relationships, only: [:create, :destroy]
  resources :microposts do
   resources :likes, only: [:create, :destory]
  end 
  
end
