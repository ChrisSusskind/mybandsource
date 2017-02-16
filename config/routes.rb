Rails.application.routes.draw do
  resources :genres
  resources :artists
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  #Subscription routes
  post '/subscriptions/:artist_id', to: 'subscriptions#create'
  delete '/subscriptions/:artist_id', to: 'subscriptions#destroy'
  get '/users/:user_id/subscriptions', to: 'subscriptions#user_subscriptions'
  get '/artists/:artist_id/subscriptions', to: 'subscriptions#artist_subscriptions'
end
