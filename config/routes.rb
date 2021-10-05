Rails.application.routes.draw do
  resources :projects
  resources :reviews
  resources :products
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "documents#new"
  resources :documents
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
