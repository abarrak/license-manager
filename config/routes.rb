Rails.application.routes.draw do
  get 'expiry_list/index'
  # root route
  root "static_pages#main"

  # static pages routes
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # REST routes
  resources :licenses

  resources :expiry_list, only: [:index]
end
