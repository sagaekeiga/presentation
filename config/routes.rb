Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  
 resources :users do
    member do
      get :following, :followers
      get :likes, :like_microposts
      get :clips, :clip_microposts
    end
  end  

  resources :microposts, only:[:create, :destroy, :show, :edit, :update, :new] do
    member do
       get :like_users
       get :clip_users
    end
    resource :likes, only: [:create, :destroy]
    resource :clips, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  
  #コメント
  resources :comments, only:[:create, :destroy]
end
