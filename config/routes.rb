Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile'},
            controllers: {omniauth_callbacks: "omniauth_callbacks"}
            
  get 'pages/about'
  get 'myprojects', to: 'projects#list'
  
  post '/free', to: 'charges#free'
  post '/pay', to: 'charges#pay'
  
  root 'projects#index'
  
  resources :projects do 
    resources :tasks, only: [:show]
    resources :reviews, only: [:create, :destroy]
  end
end
