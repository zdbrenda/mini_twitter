Rails.application.routes.draw do
  root "static_pages#home"
  match '/about',   to: 'static_pages#about',    via: 'get'
  match 'contact',  to: 'static_pages#contact', via: 'get'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
