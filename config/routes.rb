Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do
      resources :notes

      resources :walls

      resources :friends, only: [:show, :index] do
        delete 'remove', to: 'subscribings#destroy'

        post 'block', to: 'block_users#create'

        delete 'unblock', to: 'block_users#destroy'
      end
      
      resources :subscribers, only: [:index, :show] do
        post 'request', to: 'subscribings#create'

        post 'block', to: 'block_users#create'

        delete 'unblock', to: 'block_users#destroy'
      end

      resources :subscribings, only: [:create, :show, :index] do

        delete 'remove', to: 'subscribings#destroy'

      end

      get 'blacklist', to: 'block_users#index'

      get 'blacklist/:id', to: 'block_users#show'

      delete 'blacklist/:id/unblock', to: 'block_users#destroy'
    end

    resources :users, only: [:show, :index] do
      resources :walls

      resources :subscribers, only: [:show, :index]
      
      post 'request', to: 'subscribings#create'

      post 'block', to: 'block_users#create'

      delete 'unblock', to: 'block_users#destroy'

      resources :friends, only: [:show, :index]

      delete 'remove', to: 'subscribings#destroy'
    end
  end
end
