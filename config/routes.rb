Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'rooms/show'
  
  get 'pages/agreement'
  get 'pages/privacy'
  get 'pages/help'
  
  get 'pages/prototype'
  get 'pages/presentation'
  get 'pages/rank'
  get 'pages/palace'
  
  get 'microposts/admin_palace'
  get 'users/user_rank'
  
  

  resource :contacts, only: [:new, :create]
  
  
  resources :tags, only: [:index, :new, :create, :edit, :update]
  

  root 'pages#index'
  devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations',
  confirmations: 'users/confirmations'
} 

 resources :users do
    member do
      get :following, :followers
      get :likes, :like_microposts
      get :clips, :clip_microposts
      get :tags
      get :clip_posts
      get :like_posts
      get :following_users
      get :followed_users
    end
  end  

  resources :microposts, only:[:create, :destroy, :show, :edit, :update, :new, :index] do
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
  mount ActionCable.server => '/cable'

end
