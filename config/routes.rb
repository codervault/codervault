Rails.application.routes.draw do

  resources :vaults do
    resources :snippets
  end

  devise_for :users

  authenticated :user do
    root "vaults#index", as: :authenticated_root
    get "explore", to: "home#index", as: "explore"
  end

  get "about", to: "home#about", as: "about"

  root to: "home#index"

end
