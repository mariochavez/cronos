Rails.application.routes.draw do
  resources :projects, only: :show
  resources :time_tracks, path: 'track', only: :create

  root to: 'projects#index'
end
