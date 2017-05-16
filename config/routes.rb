Rails.application.routes.draw do
  resources :genres

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
  post '/search_artists', to: 'artists#search_artists'
  post '/submit_search', to: 'artists#get_artist'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
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

  patch '/users/:id/profile_picture', to: 'users#upload_avatar'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  #Subscription routes
  post '/subscriptions/:artist_id', to: 'subscriptions#create'
  delete '/subscriptions/:artist_id', to: 'subscriptions#destroy'
  get '/users/:user_id/subscriptions', to: 'subscriptions#user_subscriptions'
  get '/artists/:artist_id/subscriptions', to: 'subscriptions#artist_subscriptions'

  #Notification routes
  post '/notifications/mark_viewed_user', to: 'notifications#mark_viewed_user'
  post '/notifications/mark_viewed_artist', to: 'notifications#mark_viewed_artist'
end
