require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#index'

  get 'redirect/:monitor_id', controller: :redirects, action: :redirect, as: :redirect

  namespace :about do
    root '', action: :index
  end

  namespace :resources do
    root '', action: :index
  end

  devise_for :users

  resources :users, only: [] do
    resources :rss_feeds, only: :show
  end

  namespace :current_user do
    resource :profile
    resource :notifications, only: :show
    resources :rss_feeds

    resources :selector_suggestions, only: [:new, :create]
    get 'selector_suggestions/success'
  end

  namespace :u do
    get ':slug', controller: :public_dashboards, action: :show
  end

  namespace :admin do
    resources :users
    resources :app_monitors
    resources :monitor_results do
      get :diff
    end
    resources :selector_suggestions do
      post :confirm
    end
    resources :notifications
    resources :user_categories
    resources :user_monitors

    root to: "users#index"
  end

  namespace :api do
    scope :v1 do
      resources :refresh_app_monitor, only: :create
      resources :clear_notifications, only: :create
    end
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :user_categories do
    resources :user_monitors, shallow: true
  end
end
