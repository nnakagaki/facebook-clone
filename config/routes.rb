Rails.application.routes.draw do
  resources :users
  resources :statuses
  resource :session
end
