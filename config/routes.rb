Rails.application.routes.draw do
  devise_for :users
  root to: 'tournaments#index'

  resources :tournaments do
    post "busted"
    post "copy"
    resources :rounds, only: [:new, :create, :edit, :update, :destroy] do
      member do
        post "start_countdown"
        post "pause_countdown"
        post "reset_tournament"
      end
    end
  end
end
