Rails.application.routes.draw do
  get 'brands/index'
  get 'brands/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Root URI
  root "products#index"

  # Products Routes
  # get "/products", to: "products#index"
  get '/products/:id', to: "products#show", as: "product"
end
