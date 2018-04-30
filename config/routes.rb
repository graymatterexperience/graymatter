Rails.application.routes.draw do
  root to: 'pages#index'

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
  resources :students
end
