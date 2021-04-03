Rails.application.routes.draw do

  get    'static/index'
  get    'api/gallery/:user_id/index', to: 'galleries#index'
  get    'api/gallery/:id/show', to: 'galleries#show'
  post   'api/gallery/create', to: 'galleries#create'
  put    'api/gallery/:id/update', to: 'galleries#update'
  put    'api/gallery/:id/pic', to: 'galleries#update_pics'
  delete 'api/gallery/:id/delete/:photo_id', to: 'galleries#delete'

  post   'api/reset_password/create', to: 'reset_password#create'
  get    'api/reset_password/check_token/:token', to: 'reset_password#check_token'
  put    'api/auth/reset_password/:token', to: 'reset_password#reset_password'
  post   'api/auth/login', to: 'authentication#authenticate'
  post   '/api/auth/signup', to: 'users#create'

  get    'users/index', to: 'users#index'
  get    'api/users/:id', to: 'users#show'

  put    'users/:id/update', to: 'users#update'
  delete 'users/:id/delete', to: 'users#delete'
  post   'api/users/:id/avatar', to: 'users#upload_avatar'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/api/microposts/:micropost_id/comments', to: 'comments#index'
  post   '/api/microposts/:micropost_id/comments', to: 'comments#create'
  get    '/api/microposts/:micropost_id/comments/:id', to: 'comments#show'
  put    '/api/microposts/:micropost_id/comments/:id', to: 'comments#update'
  delete '/api/microposts/:micropost_id/comments/:id', to: 'comments#destroy'

  get    '/api/microposts/:limit/:offset', to: 'microposts#index'
  post   '/api/microposts', to: 'microposts#create'
  get    '/api/microposts/:id', to: 'microposts#show'
  put    '/api/microposts/:id', to: 'microposts#update'
  put    '/api/microposts/:id/pic', to: 'microposts#update_pic'
  delete '/api/microposts/:id', to: 'microposts#destroy'
  delete '/api/microposts/:id/delete/:photo_id', to: 'microposts#delete_photos'

  # resources :microposts do
  #   resources :comments
  # end

end
