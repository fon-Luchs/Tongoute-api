Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do
      resources :notes

      resources :walls
    end

    resources :users, only: [:show, :index] do
      resources :walls
    end
  end
end
