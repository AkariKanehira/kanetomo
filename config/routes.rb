Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  resources :sakes do
    resources :likes, only: [:create, :destroy]
  end
  resources :perfumes

  resources :tags do
    get 'sakes', to: 'sakes#search'
  end
  root "hello#index"
end
