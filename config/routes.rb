Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show]

  scope ':username', defaults: { username: 'default' } do
    resources :vaults do
      resources :snippets
    end
  end

  authenticated :user do
    root "vaults#index", as: :authenticated_root
    get "explore", to: "home#index", as: "explore"
  end

  get "about", to: "home#about", as: "about"

  root to: "home#index"
end