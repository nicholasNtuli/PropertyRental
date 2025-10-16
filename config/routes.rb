Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'api/v1/login',
    sign_out: 'api/v1/logout',
    registration: 'api/v1/signup'
  },
  controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations'
  }

  namespace :api do
    namespace :v1 do
      # Profile
      get 'profile', to: 'users#show'
      patch 'profile', to: 'users#update'

      # Properties
      resources :properties do
        collection do
          get 'featured'
          get 'search'
        end
        member do
          post 'upload_photos'
        end
        resources :reviews, only: [:index, :create, :update, :destroy]
      end

      get 'my_properties', to: 'properties#my_properties'
      get "up" => "rails/health#show", as: :rails_health_check

      # Bookings
      resources :bookings do
        member do
          patch 'confirm'
          patch 'cancel'
        end
      end

      # Favorites
      resources :favorites, only: [:index, :create, :destroy]

      # Amenities
      resources :amenities, only: [:index]

      # Health check
      get 'health', to: proc { [200, {}, ['OK']] }
    end
  end
end