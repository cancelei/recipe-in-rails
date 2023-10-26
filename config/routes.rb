Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }


  devise_scope :user do
    authenticated :user do
      root 'dashboard#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  root to: 'dashboard#index'
  resources :foods
  resources :recipes
  get 'public_recipes/index', to: 'public_recipes#index', as: 'public_recipes_index'

end
