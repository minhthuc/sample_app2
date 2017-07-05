Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/:page", to: "static_pages#show"
  get "/signup", to: "users#new"
  resources :users
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
end
