Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do
      resources :notes

      resources :walls

      resources :subscribers, only: [:show, :index] do
        post 'accept', to: 'friends#create'
      end

      resources :friends, only: [:show, :index] do
        delete 'remove', to: 'friends#destroy'
      end
    end

    resources :users, only: [:show, :index] do
      resources :walls

      resources :subscribers, only: :index

      post 'request', to: 'subscribers#create' 

      resources :friends, only: [:show, :index]

      post 'accept', to: 'friends#create'

      delete 'remove', to: 'friends#destroy'
    end
  end
end
