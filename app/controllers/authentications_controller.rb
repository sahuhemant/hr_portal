class AuthenticationsController < NewController
  skip_before_action :authenticate_request
  skip_before_action :authorize_hr

  # Login for Both Hr and Employee

  def login
    user = User.find_by(username: params[:username])
    
    if user.password == params[:password]
      token = encode(user_id: user.id, type: user.type)
      render json: { token: token, message: "#{user.type} login successful" }
    else
      render json: { error: 'Invalid name or password' }, status: :unauthorized
    end
    rescue
      render json: {message: "Invalid"}
  end
end

