Rails.application.routes.draw do
  resources :users
  resources :posts
  resources :comments
  resource :session
end
