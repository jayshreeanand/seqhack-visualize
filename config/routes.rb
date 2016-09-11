Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get "select-front" => "pages#select_front"
  get "select-back" => "pages#select_back"
  get "select-arm" => "pages#select_arm"
  root 'pages#home'
  get 'home' => 'pages#home'
  get 'dashboard' => 'pages#dashboard'

  resources :uploads do
    collection do
      post :create
    end
  end

end
