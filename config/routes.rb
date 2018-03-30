Rails.application.routes.draw do
  get 'site/index'

  resources :species
  resources :reports
  resources :birds_of_species
  resources :banders
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'site#index'
  get 'sessions/logged_in', to: 'sessions#logged_in'
end
