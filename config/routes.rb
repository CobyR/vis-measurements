Rails.application.routes.draw do

  devise_for :users

  root to: 'welcome#welcome'

  resources :devices

  resources :dashboards do
    collection do
      put 'refresh', action: 'index'
      get 'refresh', action: 'index'
    end
  end

  resource :profile, controller: 'profile'

  resources :widgets do
    resources :data_sources
    member do
      put 'refresh', action: 'show'
      get 'refresh', action: 'show'
    end
  end

end
