# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
    registrations: 'accounts/registrations',
    confirmations: 'accounts/confirmations'

  }

  get 'accounts/confirmation_pending', to: 'profiles#after_registration_path'
  get 'accounts/after_confirmation', to: 'profiles#after_confirmation_path'
  post 'profiles/search', to: 'profiles#search'
  # get '/profiles/:profile_id/friendship/follow', to: 'friendships#follow'
  # get ' /profiles/:profile_id/friendship/unfollow', to: 'friendships#unfollow'
  root to: 'homes#index'
  resources :profiles, only: %i[new create index edit show] do
    member do
      get '/friendships/follow', to: 'friendships#follow'
      get 'friendships/unfollow', to: 'friendships#unfollow'
    end
  end
  resources :posts, only: %i[new create destroy edit] do
    resources :comments, :likes, shallow: true
  end
end
