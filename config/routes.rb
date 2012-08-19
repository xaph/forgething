Forgething::Application.routes.draw do
  resources :todos

  devise_for :users

  get "home/index"
  root :to => 'home#index'
end
