Rails.application.routes.draw do
  resources :genres
  resources :artists do
    resources :reviews, only: [:create, :update, :destroy]
    post '/upvote/:id', to: 'reviews#upvote'
    delete 'upvote/:id', to: 'reviews#remove_upvote'
  end
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}


  #User and user relationship routes
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end

  #User relationship create and destroy routes
  post '/userrelationship/:id', to: 'user_relationships#create'
  delete '/userrelationship/:id', to: 'user_relationships#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  #Subscription routes
  post '/subscriptions/:artist_id', to: 'subscriptions#create'
  delete '/subscriptions/:artist_id', to: 'subscriptions#destroy'
  get '/users/:user_id/subscriptions', to: 'subscriptions#user_subscriptions'
  get '/artists/:artist_id/subscriptions', to: 'subscriptions#artist_subscriptions'
end
