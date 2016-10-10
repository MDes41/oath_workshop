Rails.application.routes.draw do
  root 'home#index'

  get '/auth/github/callback', to: 'sessions#create'

  resources :dashboard, only: [:index]
  # git '/auth/:provider/callback'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
