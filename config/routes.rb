Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resources :users, only: :create
end
