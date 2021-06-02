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
      resources :comments, only: [:create, :destroy, :index, :show, :update]
      resources :contact_us, only: [:create]
      resources :posts, only: [:create, :destroy, :index, :show, :update]
      resources :users, only: [:show, :update] do
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
