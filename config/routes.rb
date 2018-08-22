Rails.application.routes.draw do
  root to: 'pages#index'


  get 'helps/index'

  get 'message_boards/index'

  get 'updates/index'

  get 'resources/index'

  get 'workshops/index'

  get 'groups/index'
  get 'groups/show'

  get '/mentors', to: 'mentors#index'

  get 'students/index'

  get 'students/create'

  get 'students/edit'

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
  resource :calendar, only: [:show], controller: :calendar
  get 'calendar/show'
  
  # Calendar
  #resources :calendar, only: [:show], controller: :calendar
end
