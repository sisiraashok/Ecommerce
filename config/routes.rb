Rails.application.routes.draw do
  resources :shopping_carts
  resources :orders
  resources :products
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
end
