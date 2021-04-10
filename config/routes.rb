Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root "static_pages#home"
  match '/sign_up',   to: 'users#new',              via: 'get'
  match '/about',     to: 'static_pages#about',     via: 'get'
  match '/contact',   to: 'static_pages#contact',   via: 'get'
  match '/signin',    to: 'sessions#new',           via: 'get'
  match '/signin',    to: 'sessions#create',        via: 'post'
  match '/signout',   to: 'sessions#destroy',       via: 'delete'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
