Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resource :user, except: [:new, :edit]
  resources :password_resets, only: [:create, :update]
  resources :groups, except: [:new, :edit]
  resources :profiles, only: [:show, :index]
end
