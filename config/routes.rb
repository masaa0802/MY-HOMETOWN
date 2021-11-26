Rails.application.routes.draw do
  resources :videos
  devise_for :users, skip: [:sessions]
  devise_scope :user do
    get 'users/sign_in' => 'devise/sessions#new', as: :new_user_session
    post 'users/sign_in' => 'users/sessions#create', as: :user_session
    delete 'users/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :users, only: [:show, :edit, :update]
  get 'users/unsubscribe/:id' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/:id/withdraw/' => 'users#withdraw', as: 'withdraw_user'
  put 'withdraw/:id' => 'customers#withdraw'

  resources :posts do
    resources :maps, only: [:create]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:update, :destroy, :create, :new]
  end
end
