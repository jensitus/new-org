Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get    '/api/postings/:posting_id/comments', to: 'comments#index'
  # post   '/api/postings/:posting_id/comments', to: 'comments#create'
  # get    '/api/postings/:posting_id/comments/:id', to: 'comments#show'
  # put    '/api/postings/:posting_id/comments/:id', to: 'comments#update'
  # delete '/api/postings/:posting_id/comments/:id', to: 'comments#destroy'
  # get    '/api/postings', to: 'postings#index'
  # post   '/api/postings', to: 'postings#create'
  # get    '/api/postings/:id', to: 'postings#show'
  # put    '/api/postings/:id', to: 'postings#update'
  # delete '/api/postings/:id', to: 'postings#destroy'

  resources :postings do
    resources :comments
  end

end
