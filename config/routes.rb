Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get "select_front" => "pages#select_front"
  get "select_back" => "pages#select_back"
  get "select_arm" => "pages#select_arm"
  root 'pages#home'
  get 'home' => 'pages#home'
  get 'dashboard' => 'pages#dashboard'
  
  get 'view-model' => 'pages#view_model'
  
  get 'models/UCS_config.json' => 'pages#ucs_config'
  get 'js/umich_ucs.js' => 'pages#umich_ucs'
  get 'skins/Asian_Male.jpg' => 'pages#asian_male'
  resources :uploads do
    collection do
      get :new
      post :create
      get :index
    end
  end

end
