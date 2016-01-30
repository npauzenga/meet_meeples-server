Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resource  :user, except: [:new, :edit]
  resources :game_nights, except: [:new, :edit]
  resources :password_resets, only: [:create, :update]
  resources :groups, except: [:new, :edit]
  resources :profiles, only: [:show, :index]
  resources :group_memberships, only: [:create]
  resources :game_night_attendances, only: [:create]
end
