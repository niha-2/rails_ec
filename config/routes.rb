# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :products
  end

  resources :products, only: %i[index show new create edit update destroy]
  resources :tasks
  resources :carts, only: %i[new]
  resources :cart_products
  resources :cart_products do
    member do
      post 'add_product_to_cart'
      post 'add_some_products_to_cart_product'
    end
  end

  root to: 'products#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
