Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
