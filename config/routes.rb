Rails.application.routes.draw do
  resources :authentication, only: [] do
    post :singup, on: :collection
    post :login, on: :collection
    post :logout, on: :collection
  end
  namespace :api do
    namespace :v1 do
      resources :comments, only: %i[index create update]
      resources :users, only: %i[index update destroy]
    end
  end

  match '*path', to: 'application#catch_all', via: :all
end
