Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  root "hello#index"


  resources :sakes do
    resources :likes, only: [:create, :destroy]
  end
  
  resources :perfumes
  resources :hello

  resources :tags do
    get 'sakes', to: 'sakes#search'
  end
end
