Rails.application.routes.draw do
  resources :forms do
    resources :form_fields, only: [:new, :create, :edit, :update, :destroy]
    resources :responses
  end

  root "forms#index"
end
