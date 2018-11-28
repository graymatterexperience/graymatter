Rails.application.routes.draw do
  #namespace :admin do
    #get 'mentors/index'
  #end

  #namespace :admin do
    #get 'mentors/show'
  #end

  #namespace :admin do
    #get 'mentors/new'
  #end

  #namespace :admin do
    #get 'mentors/create'
  #end

  #namespace :admin do
    #get 'mentors/edit'
  #end

  #namespace :admin do
    #get 'mentors/update'
  #end

  #namespace :admin do
    #get 'mentors/archive_mentor'
  #end
  
  # sessions 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  root to: 'pages#index'

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
    resources :cohorts
  end

  namespace :admin do
    resources :users
    post '/archive/:id', to: 'users#archive_student', as: 'archive'
  end


  
  # mentors
  get '/mentors', to: 'mentors#index'

  #get  '/signup',  to: 'users#new'
  #post '/signup', to: 'users#create'

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

  # reset password 
  resources :password_resets, only: [:new, :update]

  #get '/password_resets/edit' => 'password_resets#edit', as: :edit_password_reset
  #put '/password_resets/' => 'password_resets#update', as: :password_reset
end
