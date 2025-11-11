Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"

  namespace :api do
    namespace :v1 do
      # Users routes
      resources :users, only: [ :create, :show, :update ] do
        collection do
          post :login
          post :forgot_password
          post :change_password
        end
      end

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

  get "*path", to: "dashboard#index", via: :all
end
