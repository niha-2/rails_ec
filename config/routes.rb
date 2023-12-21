# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :purchase_details
  end

  resources :products, only: %i[index show new create edit update destroy]
  resources :carts, only: %i[new]
  resources :cart_products
  resources :cart_products do
    member do
      post 'add'
    end
  end
  resources :billing_infos, only: %i[create]
  resources :cart_promotion_codes, only: %i[create]

  root to: 'products#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
