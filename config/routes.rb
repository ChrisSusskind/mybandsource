Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Homepage route
  root 'home#index'

  # Genre routes
  resources :genres

  # Artist routes and review (shown on artist profile page) routes
  resources :artists do
    resources :reviews, only: [:create, :update, :destroy] do
      member do
        post 'upvote'
        delete 'remove_upvote'
      end
      resources :responses, only: [:create, :destroy] do
        member do
          post 'upvote'
          delete 'remove_upvote'
        end
      end
    end
    get '/reviews/reorder/:recent_order', to: 'reviews#reorder'
    get '/reviews/show_responses', to: 'reviews#show_responses'
    get '/reviews/hide_responses', to: 'reviews#hide_responses'
  end

  # Searchbar routes
  post '/search_artists', to: 'artists#search_artists'
  post '/submit_search', to: 'artists#get_artist'

  # Devise routes
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }

  # Non-devise user routes and review (shown on user profile page) routes
  resources :users, only: [:index, :show] do
    resources :reviews, only: [] do
      member do
        delete 'destroy_userprofile'
        post 'upvote_userprofile'
        delete 'remove_upvote_userprofile'
      end
    end
    get '/reviews/reorder/:recent_order', to: 'reviews#reorder_userprofile'
    get '/reviews/show_responses', to: 'reviews#show_responses_userprofile'
    get '/reviews/hide_responses', to: 'reviews#hide_responses_userprofile'
  end

  #User relationship create and destroy routes
  post '/userrelationship/:id', to: 'user_relationships#create'
  delete '/userrelationship/:id', to: 'user_relationships#destroy'

  # User uploading images (using cloudinary) routes
  patch '/users/:id/profile_picture', to: 'users#upload_avatar'

  #Subscription routes
  post '/subscriptions/:artist_id', to: 'subscriptions#create'
  delete '/subscriptions/:artist_id', to: 'subscriptions#destroy'
  get '/users/:user_id/subscriptions', to: 'subscriptions#user_subscriptions'
  get '/artists/:artist_id/subscriptions', to: 'subscriptions#artist_subscriptions'

  #Notification routes
  resources :notifications, only: [:index]
  post '/notifications/mark_viewed_user', to: 'notifications#mark_viewed_user'
  post '/notifications/mark_viewed_artist', to: 'notifications#mark_viewed_artist'
end
