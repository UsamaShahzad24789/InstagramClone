Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions'
  }
  root to: 'profiles#index'
  resources :profiles ,only: [:new,:create,:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
