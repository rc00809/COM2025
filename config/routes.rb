Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  resources :books do
    member do
      put "add", to: "books#lib"
      put "remove", to: "books#lib"
    end
  end
  resources :lib, only:[:index]
  resources :prices, only:[:index]
  root 'books#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :subs
end
