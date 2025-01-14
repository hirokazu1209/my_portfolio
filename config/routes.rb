Rails.application.routes.draw do
  root to: 'homes#top'

  resources :homes, only: [:edit, :update]
  resources :items, only: [:index]

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
