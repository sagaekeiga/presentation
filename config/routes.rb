Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  
 resources :users do
    member do
      get :following, :followers
      get :likes, :like_microposts
    end
  end  

  resources :microposts, only:[:create, :destroy, :show, :edit, :update, :new] do
    resource :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  
  #コメント
  resources :comments, only:[:create, :destroy]
end
