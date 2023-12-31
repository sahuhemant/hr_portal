class NewController < ApiController
  include JsonWebToken
  
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
  before_action :authenticate_request
  before_action :authorize_hr

  private

  # Authorization for Employee
  
  def authenticate_request
    authorization_header = request.headers['Authorization']
    token = authorization_header.split(' ').last if authorization_header.present?
    decoded_token = decode(token) if token.present?
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless decoded_token
    @current_user = User.find_by(id: decoded_token['user_id'])
    return render json: { error: 'User not found' }, status: :unauthorized unless @current_user
  end

  # Authorization for HR
  
  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    
    unless payload && (payload['type'] == 'Hr' )
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end