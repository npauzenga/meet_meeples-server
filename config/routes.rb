Rails.application.routes.draw do
  mount Apitome::Engine => "/docs"
  mount Knock::Engine => "/signin"

  resource  :user, except: [:new, :edit]
  resources :password_resets, only: [:create, :update]
  resources :profiles, only: [:show, :index]

  resources :groups, except: [:new, :edit] do
    resources :group_memberships, only: [:create]
  end

  resources :game_nights, except: [:new, :edit] do
    resources :game_night_attendances, only: [:create]
  end
end
