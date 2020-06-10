Rails.application.routes.draw do
  root to: 'static_pages#home'
  
  resources :pets do
    resources :likes
  end

  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
