Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :restaurants, only:[:index ,:show] do 
    resources :comments, only:[:create,:destroy]
    
    collection do
      get :feeds # 瀏覽所有餐廳的最新動態
      get :ranking # 瀏覽餐廳排名
    end

    
    member do
      get :dashboard # 瀏覽個別餐廳的 Dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end
  end
  root "restaurants#index"
  resources :users, only:[:index,:show,:edit,:update]
  resources :categories, only: :show
  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end



  resources :followships, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy,:update] 

end
