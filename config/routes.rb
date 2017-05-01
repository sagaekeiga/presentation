Rails.application.routes.draw do

  get 'rooms/show'
  get 'pages/agreement'
  get 'pages/privacy'
  get 'pages/help'

  resource :contacts, only: [:new, :create]
  

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
