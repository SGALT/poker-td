Rails.application.routes.draw do
  devise_for :users
  root to: 'tournaments#index'

  resources :tournaments do
    post "busted"
    post "copy"
    member do
      post "start_countdown"
      post "pause_countdown"
      post "reset_tournament"
    end
    resources :rounds, only: [:new, :create, :edit, :update, :destroy] do
    end
  end
end
