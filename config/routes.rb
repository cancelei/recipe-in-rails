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

  get 'generate_shopping_list', to: 'recipes#generate_shopping_list', as: 'generate_shopping_list'

  root to: 'dashboard#index'
  resources :foods
  resources :public_recipes, only: [:index]

  resources :recipes do
    resources :recipe_foods, only: [:create, :destroy]
    member do
      get :generate_shopping_list
    end
  end

end
