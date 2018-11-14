Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do
      resources :notes

      resources :walls

      resources :subscribers, only: [:show, :index] do
        post 'accept', to: 'friends#create'

        post 'block', to: 'block_users#create'

        delete 'unblock', to: 'block_users#destroy'
      end

      resources :friends, only: [:show, :index] do
        delete 'remove', to: 'friends#destroy'

        post 'block', to: 'block_users#create'

        delete 'unblock', to: 'block_users#destroy'
      end

      get 'blacklist', to: 'block_users#index'

      get 'blacklist/:id', to: 'block_users#show'
    end

    resources :users, only: [:show, :index] do
      resources :walls

      resources :subscribers, only: :index

      post 'request', to: 'subscribers#create' 

      resources :friends, only: [:show, :index]

      post 'accept', to: 'friends#create'

      delete 'remove', to: 'friends#destroy'

      post 'block', to: 'block_users#create'

      delete 'unblock', to: 'block_users#destroy'
    end
  end
end
