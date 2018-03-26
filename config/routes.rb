Rails.application.routes.draw do
  root to: 'pages#index'
  get '/mentors', to: 'mentors#index'
end
