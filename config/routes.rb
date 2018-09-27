Rails.application.routes.draw do
  root to: 'pages#index'

  namespace :admin do
    get 'users/new'
  end

  namespace :admin do
    get 'users/create'
  end

  namespace :admin do
    get 'users/edit'
  end

  namespace :admin do
    get 'users/update'
  end

  namespace :admin do
    get 'users/destroy'
  end

  namespace :admin do
    get 'users/index'
  end

  namespace :admin do
    get 'users/show'
  end


  get 'helps/index'

  get 'message_boards/index'

  get 'updates/index'

  get 'resources/index'


  get 'groups/index'
  get 'groups/show'

  get '/mentors', to: 'mentors#index'

  get 'students/index'

  get 'students/create'

  get 'students/edit'

  get '/home', to: 'pages#index'
  get 'users/new', to: 'users#new'

  resources :cohorts, :users

  namespace :admin do
    resources :cohorts, :users
  end

  # sessions 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # mentors
  get '/mentors', to: 'mentors#index'

  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  # students
  resources :posts
  resources :students
  resource :calendar, only: [:show], controller: :calendar
  get 'calendar/show'
  
  # Calendar
  #resources :calendar, only: [:show], controller: :calendar
  resources :events

  #workshop
  get 'workshops/index'
  get '/workshops/:id', to: 'workshops#show', as: 'workshop'
end
