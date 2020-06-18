Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get '/whispaw', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  
  devise_for :users, path: "mon_compte"
  resource :users, :except => [:new, :create, :index, :destroy], path: "mon_profil"
  resources :tags, :except => [:edit, :update]
  resources :pets, path: "animaux" do
    resources :likes
    member do
      delete :delete_photo
    end
  end
<<<<<<< HEAD
=======

  resources :messages
  resources :chatrooms, only: [:new, :create, :show, :index], path: "mes_conversations"
  mount ActionCable.server => '/cable'
>>>>>>> 552335cc13edfa9e8f3d019836c44a24d0b6bb9d
  
  resources :messages, :only => [:index]



end
