# frozen_string_literal: true

Rails.application.routes.draw do
  resources :comments
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # , ActiveAdmin::Devise.config
  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#index', as: 'home'
  get 'add', to: 'carts#add', as: 'add_to_cart'
  get 'quantity', to: 'carts#change_quantity'
  get 'buy', to: 'orders#add_order'
  # get 'category', to: 'pages#category', as: 'category'
  resources :orders
  get 'order_list', to: 'orders#index', as: 'order_index'
  post 'valid_email', to: 'orders#valid_email', as: 'valid_email'
  resources :carts
  resources :pages
  resources :comments
  resources :categories, only: :show do
    get 'range', on: :collection
    get 'search', on: :collection
    get 'searchdo', on: :collection
    resources :products, only: %i[index show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

