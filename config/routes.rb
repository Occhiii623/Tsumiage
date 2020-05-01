Rails.application.routes.draw do
  get 'tags/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: :show
  resources :tags, only: [:index, :show]
end