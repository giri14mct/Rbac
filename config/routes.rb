Rails.application.routes.draw do
  resources :authentication, only: [] do
    post :singup, on: :collection
    post :login, on: :collection
    post :logout, on: :collection
  end
  namespace :api do
    namespace :v1 do
      resources :users, only: :index do
        # post :singup, on: :collection
      end
    end
  end
end
