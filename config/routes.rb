# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users#, ActiveAdmin::Devise.config
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#index', as: 'home'
  get 'add', to: 'carts#add', as: 'add_to_cart'
  get 'quantity', to: 'carts#change_quantity'
  get 'buy', to: 'orders#add_order'
  # get 'category', to: 'pages#category', as: 'category'
  resources :orders
  get 'order_list', to: 'orders#index', as:'order_index'
  resources :carts
  resources :pages
  resources :categories, only: :show do
    get 'range', on: :collection
    get 'search', on: :collection
    get 'searchdo', on: :collection
    resources :products, only: %i[index show]
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
