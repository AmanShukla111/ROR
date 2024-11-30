Rails.application.routes.draw do
  devise_for :users
  
  resources :forms do
    post :create_invite
    post :invite_user
    resources :form_invites, only: [:create, :index, :destroy] do
      delete :revoke, on: :member  # This creates a route for revoking the invite
    end
    resources :form_fields, only: [:new, :create, :edit, :update, :destroy]
    resources :responses
  end

  root "forms#index"
end
