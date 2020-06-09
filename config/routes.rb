Rails.application.routes.draw do
  resources :pets do
    resources :likes

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
