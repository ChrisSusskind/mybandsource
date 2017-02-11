Rails.application.routes.draw do
  resources :genres
  resources :artists
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

end
