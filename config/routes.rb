Rails.application.routes.draw do
  mount Knock::Engine => "/signin"

  resource :user, except: [:new, :edit]

  resources :profiles, except: [:new, :edit]
end
