# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
    registrations: 'accounts/registrations',
    confirmations: 'accounts/confirmations'

  }
  get '/admins', to: 'admins#index'
  get '/admins/status', to: 'admins#status'
  get '/admins/de_activate/:account_id', to: 'admins#de_activate', as: :admins_de_activate
  get '/admins/activate/:account_id', to: 'admins#activate', as: :admins_activate
  get 'accounts/confirmation_pending', to: 'profiles#after_registration_path'
  get 'accounts/after_confirmation', to: 'profiles#after_confirmation_path'
  post 'profiles/search', to: 'profiles#search'
  root to: 'homes#index'
  resources :profiles, only: %i[new create index edit show] do
    member do
      get '/friendships/follow', to: 'friendships#follow'
      get 'friendships/unfollow', to: 'friendships#unfollow'
    end
  end
  resources :posts, only: %i[new create edit update] do
    member do
      get '/archives/archive_post', to: 'archives#archive_post'
      get '/likes/un_like', to: 'likes#un_like'
    end
    resources :comments, :likes, shallow: true
  end
  delete '/posts/destroy', to: 'posts#destroy'
  resources :archives, only: [:index] do
    member do
      get '/archives/unArchive', to: 'archives#un_archive_post'
    end
  end
end
