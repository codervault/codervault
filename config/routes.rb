Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show]

  resources :vaults, except: [:show] do
    resources :snippets, except: [:show, :index]
  end

  get ":username/:vault_id", to: "vaults#show", as: "owner_vault"
  get ":username/:vault_id/:snippet_id", to: "snippets#show", as: "owner_snippet"

  authenticated :user do
    root "vaults#index", as: :authenticated_root
    get "explore", to: "home#index", as: "explore"
  end

  get "about", to: "home#about", as: "about"

  root to: "home#index"
end