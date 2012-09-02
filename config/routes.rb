Forgething::Application.routes.draw do
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

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "home/index"
  root :to => 'home#index'
end
