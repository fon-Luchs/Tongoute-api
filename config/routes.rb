Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do
      resources :notes

      resource :wall, only: :show do
        resources :posts, only: [:create, :update, :show, :destroy]
      end

      resources :friends, only: [:show, :index] do
        delete 'remove', to: 'friends#destroy'

        patch 'block', to: 'block_users#update'
      end
      
      resources :subscribers, only: [:index, :show]

      resources :subscribings, only: [:show, :index] do
        delete 'remove', to: 'subscribings#destroy'
      end

      post  'subscribers/:subscriber_id/accept', to: 'friends#create'

      get 'blacklist', to: 'block_users#index'

      get 'blacklist/:id', to: 'block_users#show'

      delete 'blacklist/:id/unblock', to: 'block_users#destroy'

      resources :conversations, only: [:show, :index] do
        resources :messages, only: [:create, :update]
      end

      resources :chats do
        post   'join',  to: 'user_chats#create'

        delete 'leave', to: 'user_chats#destroy'

        patch 'update', to: 'user_chats#update'

        resources :messages, only: [:create, :update]
      end
    end

    resources :users, only: [:show, :index] do
      resource :wall, only: :show do
        resources :posts, only: [:create, :update, :show, :destroy]
      end

      resources :subscribers, only: [:index]
      
      post 'block', to: 'block_users#create'

      resources :friends, only: [:index]

      resources :conversations, only: [:create, :show]

      post   'request', to: 'subscribings#create'
    end
  end
end
