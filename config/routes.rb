Rails.application.routes.draw do
  get 'site/index'

  # resources :species
  resources :reports
  resources :birds_of_species, only: [:create, :update, :destroy]
  resources :banders, only: [:index, :new, :create, :show] do
    resources :reports, only: [:index, :show]
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'site#index'
  # get 'sessions/logged_in', to: 'sessions#logged_in'
end
