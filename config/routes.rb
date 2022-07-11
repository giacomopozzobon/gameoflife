Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  
  post '/upload', controller: 'home', action: 'upload'
  post '/start', controller: 'game', action: 'start'

  get '/game', controller: 'game', action: 'index'
  get '/start', controller: 'game', action: 'start'

end
