Rails.application.routes.draw do
  # Root URI
  root "home#index"

  # Products Routes
  get "/products", to: "products#index"
  get '/products/:id', to: "products#show", as: "product"
end
