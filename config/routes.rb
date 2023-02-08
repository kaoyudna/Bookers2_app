Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

#book関連ルート
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

#users関連ルート
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get 'relationships/followers'=>'relationships#followers',as: 'follower'
    get 'relationships/followings'=>'relationships#followings',as: 'following'
  end

#検索関連ルート
  get 'searches/search'=>'searches#search',as: 'search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
