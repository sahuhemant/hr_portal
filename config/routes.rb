Rails.application.routes.draw do
  post '/login', to: 'authentications#login'
  post '/employees', to: 'employees#create'
  resources :employees, only: [:index, :create, :destroy, :update, :show]
  resources :holidays, only: [:index]
  resources :events, only: [:create, :index, :destroy, :update, :show]
  get '/users/me', to: 'users#show'
  post '/logout', to: 'users#logout'
  post '/users/apply_leave', to: 'users#apply_leave'

end
