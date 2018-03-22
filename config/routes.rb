Rails.application.routes.draw do
  get 'mentors/index'

  root to: 'pages#index'
end
