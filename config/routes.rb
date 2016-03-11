Rails.application.routes.draw do

  devise_for :users

  root to: 'welcome#welcome'

  resources :devices

  resources :dashboards

  resource :profile, controller: 'profile'

  resources :widgets do
    resources :data_sources
  end

end
