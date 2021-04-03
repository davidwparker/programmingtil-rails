Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      confirmations: 'confirmations',
      passwords: 'passwords',
      registrations: 'registrations',
      sessions: 'sessions',
    }

  # Ping to ensure site is up
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end

  # APIs
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create, :destroy, :update, :index]
      resources :users, only: [:update] do
        collection do
          get :available
        end
      end
    end
  end

  namespace :users do
    get "sign-in", to: "sessions#new"
  end
end
