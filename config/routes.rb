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
  root to: 'homes#index'
  resources :profiles, only: %i[new create index edit show] do
    resource :friendship, shallow: true, only: %i[new edit]
  end
  resources :posts, only: %i[new create destroy edit] do
    resources :comments, :likes, shallow: true
  end
end
