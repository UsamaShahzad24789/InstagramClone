Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
    registrations: 'accounts/registrations',
    confirmations: 'accounts/confirmations',

  }

  get 'accounts/confirmation_pending',to: 'profiles#after_registration_path'
  get 'accounts/after_confirmation',to: 'profiles#after_confirmation_path'
  root to: 'profiles#index'
  resources :profiles ,only: [:new,:create,:index]
  resources :posts ,only: [:new,:create]
  get 'posts/options' ,to: 'posts#post_options'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
