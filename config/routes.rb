require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#index'
  get 'about', controller: 'application', action: 'about'
  get 'redirect/:monitor_id', controller: :redirects, action: :redirect, as: :redirect

  devise_for :users

  mount Sidekiq::Web => '/sidekiq'

  resources :user_categories do
    resources :user_monitors, shallow: true
  end
end
