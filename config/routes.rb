Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  
 resources :users do
    member do
      get :following, :followers
    end
  end  
  resources :microposts
  
  resources :relationships, only: [:create, :destroy]
end
