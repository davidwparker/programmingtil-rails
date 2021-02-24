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
end
