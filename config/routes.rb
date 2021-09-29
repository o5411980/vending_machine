Rails.application.routes.draw do
  root to: "documents#index"
  resources :documents
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
