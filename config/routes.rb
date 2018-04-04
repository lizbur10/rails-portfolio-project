Rails.application.routes.draw do
  get 'site/index'

  # resources :species
  resources :reports, only: [:index]
  resources :birds_of_species, only: [:create, :update, :destroy]
  resources :banders, only: [:index, :new, :create, :show, :edit, :update] do
    resources :reports
  end

  get '/banders/:bander_id/reports/:id/preview' => 'reports#/preview', as: :preview_bander_report
  post '/reports/:id/post_report' => 'reports#post_report', as: :post_report

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'site#index'
end
