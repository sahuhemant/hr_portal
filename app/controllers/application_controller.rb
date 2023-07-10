class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request
  
  private
  
  def authenticate_request
    authorization_header = request.headers['Authorization']
    token = authorization_header.split(' ').last if authorization_header.present?
    decoded_token = decode(token) if token.present?
    unless decoded_token
      render json: { error: 'Unauthorized' }, status: :unauthorized
      return
    end

    @current_user = User.find_by(id: decoded_token['user_id'])
    unless @current_user
      render json: { error: 'User not found' }, status: :unauthorized
      return
    end
  end
end
  