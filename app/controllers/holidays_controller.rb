class HolidaysController < ApplicationController
  skip_before_action :authenticate_request
  # before_action :authorize_hr
  #because holiday can access both
  def index
    holidays = Holiday.all
    render json: holidays
  end
   
  private
  
  def authorize_hr 
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
    
end