Rails.application.routes.draw do
  get '/profile', to: 'users#profile', as: :user_profile

root "recommendations#index"

  devise_for :users

  resources :books do
    resources :recommendations, only: [:new, :create]
  end

  resources :recommendations, only: [:create, :destroy] do
    resources :votes, only: [:create, :destroy]
  end

  resources :profiles, only: [:show]


  resources :recommendations do
    resources :votes, only: [:create]
  end

end
