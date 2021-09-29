Rails.application.routes.draw do
  devise_for :users
  root to: "documents#index"
  resources :documents
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
