require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root "purchases#index"
  resources :purchases do
    get 'items', to: 'purchase_items#index', on: :member
  end

  resources :purchase_items, only: %i[edit update destroy]

  namespace :mobile_app do
    get 'purchases_list', to: 'purchases#list'
    get 'purchase/:id', to: 'purchases#purchase'
    get 'purchase_items/:id', to: 'purchases#purchase_items'
    post 'create_purchase', to: 'purchases#create'
    post 'update_purchase', to: 'purchases#update'
    delete 'delete_purchase/:id', to: 'purchases#destroy'

    get 'all_items', to: 'purchase_items#all_items'
    get 'purchase_item/:id', to: 'purchase_items#details'
    patch 'update_purchase_item', to: 'purchase_items#update'
    patch 'mark_as_used/:id', to: 'purchase_items#mark_as_used'
    delete 'delete_purchase_item/:id', to: 'purchase_items#destroy'
  end
end
