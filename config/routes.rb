Rails.application.routes.draw do
  
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :expenses

  get "/statistics/" => "statistics#show"
  get "/statistics/:page" => "statistics#show"

  root to: 'expenses#index'
end