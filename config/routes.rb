Rails.application.routes.draw do
  post '/login', to: 'authentications#login'
  post '/employees', to: 'employees#create'
  resources :employees, only: [:index, :create, :destroy]
  resources :holidays, only: [:index]
  resources :events, only: [:create, :index, :destroy]
  get '/users/me', to: 'users#show'
  # resources :employees do
  #   member do
  #     patch :update_profile_picture
  #   end
  # end




end
