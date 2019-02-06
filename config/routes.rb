Rails.application.routes.draw do
  
  resources :balances
  resources :expense_plans
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :expenses
  resources :receipts


  get "/statistics/" => "statistics#show"
  get "/statistics/:page" => "statistics#show"

  root to: 'expenses#index'
end
