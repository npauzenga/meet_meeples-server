Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resources :users, except: [:new, :edit]
end
