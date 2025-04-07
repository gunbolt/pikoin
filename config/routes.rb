Rails.application.routes.draw do
  root "accounts#index"

  resources :accounts, except: %i[show] do
    scope module: :accounts do
      resources :records, except: %i[show]
    end
  end
  resources :categories, except: %i[show]
  resources :ordering, only: %i[update], param: :resource
  resources :record_types, only: %i[index]
  resources :templates, except: %i[show]
  resources :transfers, except: %i[index show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
