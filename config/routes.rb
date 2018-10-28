Rails.application.routes.draw do

  namespace :api do
    resource :session, only: [:create, :destroy]
  end
end
