Rails.application.routes.draw do
  root 'home#top'
 
  get 'home/help' =>"home#help"
  get 'home/about' => "home#about"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
