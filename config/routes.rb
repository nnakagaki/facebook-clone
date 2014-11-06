Rails.application.routes.draw do
  root to: "users#static"

  resources :users, only: [:new, :update, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :posts, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friend, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
  resources :messages, only: [:create]

  get "/messages/past", to: "messages#past_messages"

  post "/pusher/auth", to: "pusher#auth"

  namespace :api, defaults: { format: :json } do
    get "/users/search", to: "users#search"
    resources :users, only: [:index, :show, :update]
    get "/posts/embed", to: "posts#embed"
    resources :posts, only: [:show, :create, :destroy]
    resources :comments, only: [:show, :create, :destroy]
    resources :likes, only: [:show, :create, :destroy]
    resources :friends, only: [:create, :destroy]
    resources :friend_requests, only: [:create, :destroy, :index]
    resources :notifications, only: [:index, :update]
  end
end
