Rails.application.routes.draw do
  get 'tags/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :likes, only: :index
  resources :users, only: :show
  resources :relationships, only: [:index, :create, :destroy]
  resources :tags, only: [:index, :show]
end