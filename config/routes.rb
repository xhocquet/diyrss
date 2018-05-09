require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#index'
  get 'about', controller: 'application', action: 'about'
  get 'redirect/:monitor_id', controller: :redirects, action: :redirect, as: :redirect

  devise_for :users

  namespace :admin do
    resources :users
    resources :app_monitors
    resources :monitor_results
    resources :notifications
    resources :user_categories
    resources :user_monitors

    root to: "users#index"
  end

  mount Sidekiq::Web => '/sidekiq'

  resources :user_categories do
    resources :user_monitors, shallow: true
  end
end
