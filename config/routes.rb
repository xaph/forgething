Forgething::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'
  resources :authentications
  resources :tags

  resources :todos do
    collection do
      get 'all'
    end
    member do
      get 'star'
      get 'unstar'
      delete 'complete'
    end
  end

  devise_for :users

  get "home/index"
  root :to => 'home#index'
end
