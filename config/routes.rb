Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do
      resources :notes

      resources :walls

      resources :subscribers, only: [:show, :index]
    end

    resources :users, only: [:show, :index] do
      resources :walls

      resources :subscribers, only: :index

      post 'request', to: 'subscribers#create' 
    end
  end
end
