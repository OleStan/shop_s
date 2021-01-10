# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  resources :pages
  resources :products
  resources :categories
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
