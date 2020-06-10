Rails.application.routes.draw do
  resources :pets
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pets do
    member do
      delete "delete_photo/:photo_id", action: :delete_photo
    end
  end
end
