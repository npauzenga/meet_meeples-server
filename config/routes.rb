Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resources :users, except: [:new, :edit]
  resources :password_resets, only: [:create, :update]
end
