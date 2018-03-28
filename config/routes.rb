Rails.application.routes.draw do
  get '/mentors', to: 'mentors#index'

  get 'students/index'

  get 'students/create'

  get 'students/edit'

  get 'students/update'

  get 'students/delete'

  get 'students/show'

  root to: 'pages#index'
end
