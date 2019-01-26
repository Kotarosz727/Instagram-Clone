Rails.application.routes.draw do
  
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  
  get '/upload', to:"microposts#new"
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
   member do
    get :following, :followers
    end
  end
  #resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :microposts do
   resources :likes, only: [:new, :create, :destory]
   resources :comments, only: [:index, :create, :destroy], shallow: true
  end 
  
  
end
