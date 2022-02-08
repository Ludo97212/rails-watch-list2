Rails.application.routes.draw do
  devise_for :users
  root to: 'lists#index'
  resources :lists
  resources :bookmarks, only: %i[new create destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end