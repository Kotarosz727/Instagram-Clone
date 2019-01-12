Rails.application.routes.draw do
  
  root 'home#top'
  get '/help', to:"home#help"
  get '/about', to:"home#about"
  get  '/signup',  to: 'users#new'
  
  resources :users
  
end
