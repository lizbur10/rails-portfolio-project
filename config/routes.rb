Rails.application.routes.draw do
  get 'site/index'

  # resources :species
  resources :reports, only: [:create, :update, :index]
  resources :birds_of_species, only: [:create, :update, :destroy]
  resources :banders, only: [:index, :new, :show, :edit, :update] do
    resources :reports, only: [:show, :index, :new, :edit]
  end

  get '/banders/:bander_id/reports/:id/preview' => 'reports#preview', as: :preview_bander_report
  post '/reports/:id/post_report' => 'reports#post_report', as: :post_report
  get '/reports/by_total_banded' => 'reports#by_total_banded'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'site#index'
end
