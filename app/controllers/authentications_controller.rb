class AuthenticationsController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  skip_before_action :authorize_hr

  # Login for Both Hr and Employee

  def login
    user = User.find_by(username: params[:username])
    
    if user&.authenticate(params[:password])
      type = user.type 
      
      if type == 'Hr'
        token = encode(user_id: user.id, type: type)
        render json: { token: token, message: 'HR login successful' }
      else
        token = encode(user_id: user.id, type: type)
        render json: { token: token, message: 'Developer login successful' }
      end
    else
      render json: { error: 'Invalid name or password' }, status: :unauthorized
    end
  end
end