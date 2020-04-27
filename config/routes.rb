Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  # resources :comments, only: :destroy
  resources :users, only: :show
end