Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resources :users, except: [:new, :edit]
  resources :password_resets, only: [:create, :update]
  resources :groups, except: [:new, :edit]
  resources :game_night_attendances, only: [:create]
end
