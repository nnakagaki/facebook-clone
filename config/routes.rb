Rails.application.routes.draw do
  root to: "users#static"

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :posts, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friend, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :show]
    resources :posts, only: [:show, :create, :destroy]
    resources :comments, only: [:show, :create, :destroy]
    resources :likes, only: [:show, :create, :destroy]
    resources :friends, only: [:create, :destroy]
    resources :friend_requests, only: [:create, :destroy]
    resources :notifications, only: [:index, :update]
  end
end
