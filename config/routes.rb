Mails::Application.routes.draw do
  resources :mailing_lists
  resources :threads, only: [:show]
  resources :users, only: [:show]
  root to: "mailing_lists#index"
end
