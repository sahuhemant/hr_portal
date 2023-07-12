Rails.application.routes.draw do
  post '/login', to: 'authentications#login'
  post '/employees', to: 'employees#create'
  resources :employees, only: [:index, :create, :destroy, :update, :show]
  resources :events, only: [:create, :index, :destroy, :update, :show]
  resources :holidays, only: [:create, :index, :destroy, :update, :show]
  get '/users/me', to: 'users#show'
  post '/users/apply_leave', to: 'users#apply_leave'
  get  '/users/leave_status', to: 'users#leave_status'
  resources :leaves, only: [:index, :show, :update]

end
