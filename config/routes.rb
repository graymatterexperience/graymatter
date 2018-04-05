Rails.application.routes.draw do

  root to: 'sessions#new'
  get '/home', to: 'pages#index'
  get 'users/new', to: 'users#new'

  # sessions 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # mentors
  get '/mentors', to: 'mentors#index'

  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  # students
  resources :students         ### why do we exactly have a students controller? arent students a type of user?
end
