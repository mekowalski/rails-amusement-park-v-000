Rails.application.routes.draw do
  resources :users
  resources :attractions

  post '/rides/new' => 'rides#new'

  root 'application#home'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'
end
