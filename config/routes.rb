Forgething::Application.routes.draw do
  resources :todos do
    collection do
      get 'all'
    end
    member do
      get 'star'
      get 'unstar'
    end
  end

  devise_for :users

  get "home/index"
  root :to => 'home#index'
end
