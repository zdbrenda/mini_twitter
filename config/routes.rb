Rails.application.routes.draw do
  resources :users
  root "static_pages#home"
  match '/sign_up', to: 'users#new',              via: 'get'
  match '/about',   to: 'static_pages#about',     via: 'get'
  match 'contact',  to: 'static_pages#contact',   via: 'get'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
