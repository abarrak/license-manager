Rails.application.routes.draw do
  # root route
  root "static_pages#main"

  # static pages routes
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # REST routes
  resources :licenses do
    get :metrics, on: :collection
  end

  get "expired"      => "expiry#expired"
  get "expires_soon" => "expiry#expires_soon"
  get "stats"        => "expiry#stats"

  get    'dashboard' => "ops#dashboard"
  patch  'ops_clear' => "ops#clear"
  patch  'ops_sync'  => "ops#sync"
end
