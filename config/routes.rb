Rails.application.routes.draw do

  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
    registrations: 'accounts/registrations',
    confirmations: 'accounts/confirmations',

  }

  get 'accounts/confirmation_pending',to: 'profiles#after_registration_path'
  get 'accounts/after_confirmation',to: 'profiles#after_confirmation_path'
  root to: 'homes#index'
  resources :profiles ,only: [:new,:create,:index,:edit]
  resources :posts ,only: [:new,:create,:destroy,:edit] do
    resources :comments,:likes ,shallow: true
  end

end
