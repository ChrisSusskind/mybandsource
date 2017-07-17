Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Homepage route
  root 'home#index'

  # Genre routes
  resources :genres, only: [:show, :index]

  # Searchbar routes
  post '/search_artists', to: 'users#search_artists'
  post '/submit_search', to: 'users#get_artist'
  get '/search_results', to: 'users#render_search_page'

  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }

  # Non-devise user routes and review/response routes
  resources :users, only: [:show] do
    resources :reviews, only: [:create, :destroy, :update] do
      member do
        post 'upvote/:responses_shown', to: 'reviews#upvote'
        delete 'remove_upvote/:responses_shown', to: 'reviews#remove_upvote'
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

    #Routes for sharing review and responses
    post '/share/review/:id', to: 'reviews#share'
    post '/share/reviews/:review_id/response', to: 'responses#share'
  end

  get '/create_artist', to: 'users#create_artist'

  #User relationship create and destroy routes
  post '/userrelationship/:id', to: 'user_relationships#create'
  delete '/userrelationship/:id', to: 'user_relationships#destroy'

  # User uploading images (using cloudinary) routes
  patch '/users/:id/profile_picture', to: 'users#upload_avatar'

  #Notification routes
  resources :notifications, only: [:index]
  post '/notifications/mark_viewed_user', to: 'notifications#mark_viewed_user'
  post '/notifications/mark_viewed_artist', to: 'notifications#mark_viewed_artist'

  #Claim artist mailer route
  post '/claim_artist', to: 'users#claim_artist'

  #Report review and response routes
  post '/report_review/:id', to: 'reviews#report'
  post '/report_response/:id', to: 'responses#report'

  mount ActionCable.server, at: '/cable'
end
