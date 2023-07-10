class AuthenticationsController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request, only: [:login, :create]
  
  def login
    if params[:username] == 'hr' && params[:password] == 'hr123'
      token = encode(user_id: 'hr')
      render json: { token: token, message: 'HR login successfully' }
    else
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token = encode(user_id: user.id)
      render json: { token: token, message: 'Developer login successfully' }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
    end
  end

  private

  def authenticate_params
    params.permit(:username, :password)
  end
end
  