Rails.application.routes.draw do
  get 'site/index'

  # This needs to go first so it doesn't conflict with reports/:id
  get 'reports/posted' => 'reports#posted_reports', as: :posted_reports
  post '/reports/next_report' => 'reports#next_report', as: :next_report
  post '/reports/previous_report' => 'reports#previous_report', as: :previous_report

  # resources :species
  resources :reports, only: [:create, :update, :show]
  resources :birds_of_species, only: [:create, :index, :update, :destroy]
  resources :banders, only: [:new, :create, :show, :edit, :update] do
    resources :reports, only: [:index, :new, :show, :edit]
  end

  post '/reports/:id/add_writeup' => 'reports#add_writeup', as: :add_writeup
  post '/reports/:id/post_report' => 'reports#post_report', as: :post_report
  get '/banders/:bander_id/reports/:id/add_birds' => 'reports#add_birds', as: :add_birds
  post '/species/find_by_code' => 'species#find_by_code'
  
  # get '/reports/by_total_banded' => 'reports#by_total_banded'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'site#index'
end
