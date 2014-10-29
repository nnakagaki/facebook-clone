Rails.application.routes.draw do
  root to: "users#new"

  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :posts, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friend, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
end
