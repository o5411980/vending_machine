Rails.application.routes.draw do
  root to: "tops#index"
  post '/tops/guest_sign_in', to: 'tops#guest_sign_in'

  resources :departments
  resources :projects
  resources :reviews
  resources :products
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show]

  resources :documents
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
