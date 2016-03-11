Rails.application.routes.draw do
  get 'dashboards/index'

  devise_for :users
  get 'welcome/welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root to: 'welcome#welcome'

  resources :devices

  resources :dashboards
end
