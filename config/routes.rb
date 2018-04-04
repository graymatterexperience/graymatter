Rails.application.routes.draw do
  root to: 'pages#index'

  # sessions 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # mentors
  get '/mentors', to: 'mentors#index'

  # students
  resources :students         ### why do we exactly have a students controller? arent students a type of user?
end
