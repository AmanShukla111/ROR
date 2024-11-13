Rails.application.routes.draw do
  # Define routes for forms
  resources :forms, only: [ :index, :show ] do
    member do
      get "new_response"
      get "responses"
    end
  end

  # Define routes for responses
  resources :responses, only: [ :create ]

  # Define the root path
  root "forms#index"

  # Additional utility routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
