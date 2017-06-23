Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/:page", to: "static_pages#show"
end
