Rails.application.routes.draw do
  # namespace :admin do
  # get 'mentors/index'
  # end

  # namespace :admin do
  # get 'mentors/show'
  # end

  # namespace :admin do
  # get 'mentors/new'
  # end

  # namespace :admin do
  # get 'mentors/create'
  # end

  # namespace :admin do
  # get 'mentors/edit'
  # end

  # namespace :admin do
  # get 'mentors/update'
  # end

  # namespace :admin do
  # get 'mentors/archive_mentor'
  # end

  # sessions
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  root to: 'pages#index'

  get 'helps/index'

  get 'message_boards/index'

  get 'updates/index'

  get 'resources/index'


  get '/mentors', to: 'mentors#index'

  get 'students/index'

  get 'students/create'

  get 'students/edit'

  get '/home', to: 'pages#index'
  get 'users/new', to: 'users#new'

  resources :cohorts, :users

  namespace :admin do
    resources :users
    resources :cohorts
    resources :groups
    post '/archive/:id', to: 'users#archive_student', as: 'archive'
    get '/getStudentsByGroup/:id', to: 'groups#students_by_group'
  end

  # mentors
  get '/mentors', to: 'mentors#index'

  # get  '/signup',  to: 'users#new'
  # post '/signup', to: 'users#create'

  # students
  resources :posts
  resources :students
  resource :calendar, only: [:show], controller: :calendar
  get 'calendar/show'

  #groups
  get 'groups/index'
  get 'groups/show/:id', to: 'groups#show'

  # Calendar
  # resources :calendar, only: [:show], controller: :calendar
  resources :events

  # workshop
  get 'workshops/index'
  get '/workshops/:id', to: 'workshops#show', as: 'workshop'

  # reset password
  resources :password_resets, only: %i[new update]
end
