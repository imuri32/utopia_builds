Rails.application.routes.draw do
  # Root URI
  root to: "products#index"

  # User Routes
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
    get "/users/edit" => "devise/registrations#edit"
  end

  devise_for :users

  # Cart Routes
  resources :cart, only: [:create, :destroy]

  # Checkout Routes
  get 'checkout', to: "checkout#index"
  post 'checkout/update'
  post 'checkout/confirm'

  # Orders Routes
  get 'orders', to: "orders#index"
  get 'orders/:id', to: "orders#show", as: "order"

  # Brands Routes
  get 'brands', to: "brands#index"
  get 'brands/:id', to: "brands#show", as: "brand"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Products Routes
  get '/products/:id', to: "products#show", as: "product"

  # Home Routes
  get '/contact', to: "home#contact"
  get '/about', to: "home#about"
end
