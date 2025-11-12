Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root "dashboard#index"

  namespace :api do
    namespace :v1 do
      # Users routes
      resources :users, only: [ :show, :update ] do
        collection do
          get :index       # Admin-only: list all users
          post :login
          post :forgot_password
          post :change_password
        end
      end

      # Optional admin-only delete route
      delete "users/:id", to: "users#destroy", as: :destroy_user

      # Expenses CRUD routes
      resources :expenses, only: [ :index, :show, :create, :update, :destroy ]

      # Incomes CRUD routes
      resources :incomes, only: [ :index, :show, :create, :update, :destroy ]

      # Budgets CRUD routes
      resources :budgets, only: [ :index, :show, :create, :update, :destroy ]

      # Categories CRUD routes
      resources :categories, only: [ :index, :show, :create, :update, :destroy ]
    end
  end

  # Catch-all route for frontend
  get "*path", to: "dashboard#index", via: :all
end
