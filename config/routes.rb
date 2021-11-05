Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/create'
  get 'posts/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :users, only: [:show,:edit,:update]
    get 'users/unsubscribe/:id' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/:id/withdraw/' => 'users#withdraw', as: 'withdraw_user'
    put 'withdraw/:id' => 'customers#withdraw'
    
  resources :posts, only: [:index,:show,:edit,:create,:destroy]
end
