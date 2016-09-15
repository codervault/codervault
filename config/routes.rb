Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show]

  resources :vaults do
    resources :snippets
  end

  authenticated :user do
    root "vaults#index", as: :authenticated_root
    get "explore", to: "home#index", as: "explore"
  end

  get "about", to: "home#about", as: "about"

  root to: "home#index"
end
