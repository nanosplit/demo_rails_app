Rails.application.routes.draw do
  resources :portfolios
  devise_for :users
  root to: "home#index"
end
