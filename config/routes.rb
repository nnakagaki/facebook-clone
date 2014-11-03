Rails.application.routes.draw do
  root to: "users#static"

  resources :users, only: [:new, :update, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :posts, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friend, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]

  post "/pusher/auth", to: "pusher#auth"
  post "/pusher/webhook", to: "pusher#webhook"

  namespace :api, defaults: { format: :json } do
    get "/users/search", to: "users#search"
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:show, :create, :destroy]
    resources :comments, only: [:show, :create, :destroy]
    resources :likes, only: [:show, :create, :destroy]
    resources :friends, only: [:create, :destroy]
    resources :friend_requests, only: [:create, :destroy]
    resources :notifications, only: [:index, :update]
  end
end
