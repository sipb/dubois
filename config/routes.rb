Mails::Application.routes.draw do
  root to: "mailing_lists#index"

  post    '/mailing_lists/:id/followers' => "followers#create", as: :follower
  delete  '/mailing_lists/:id/followers' => 'followers#destroy'
  post '/search'            => "mailing_lists#search", :as => :search
  get  '/:name/threads'     => "threads#index"
  get  '/:name/threads/:id' => 'threads#show', :as => :thread
  get  '/:name'             => "mailing_lists#show", :as => :mailing_list
  post '/:name'             => "threads#search", :as => :thread_search            
end