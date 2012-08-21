Forgething::Application.routes.draw do
  resources :todos do
    collection do
      get 'all'
    end
  end

  devise_for :users

  get "home/index"
  root :to => 'home#index'
end
