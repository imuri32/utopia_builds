Rails.application.routes.draw do
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
  post 'checkout/delete'

  # Brands Routes
  get 'brands/index'
  get 'brands/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root URI
  root "products#index"

  # Products Routes
  # get "/products", to: "products#index"
  get '/products/:id', to: "products#show", as: "product"

  # Home Routes
  get '/contact', to: "home#contact"
  get '/about', to: "home#about"
end
