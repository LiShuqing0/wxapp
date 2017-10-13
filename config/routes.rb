Rails.application.routes.draw do
  root to: 'articles#index'

  get 'password_resets/new'
  get 'password_resets/edit'

  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  resources :articles
  resources :wx_users do
    get :wx_login, on: :collection
  end

  resources :users
  resources :password_resets,      only: [:new, :create, :edit, :update]




  resources :web_sites, only: [] do
    collection do
      get :rose, :fireworks, :heart
    end
  end

  namespace :back do
    resources :articles

  end
end
