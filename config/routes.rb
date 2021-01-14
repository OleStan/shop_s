# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index', as: 'home'
  get '/admin', to: 'pages#admin', as: 'admin'
  get 'admin/categories', to: 'categories#index', as: 'admin_categories'
  # get 'category', to: 'pages#category', as: 'category'
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
